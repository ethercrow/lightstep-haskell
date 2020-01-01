#!/usr/bin/env python3
"""Demonstrates a Trace distributed across multiple machines.

A SpanContext's text representation is stored in the headers of an HTTP request.

Runs two threads, starts a Trace in the client and passes the SpanContext to the server.
"""

import os
import argparse
import errno
import socket
import sys
import threading

from http.server import BaseHTTPRequestHandler, HTTPServer

import opentracing
import opentracing.ext.tags
import lightstep
from opentracing import Format
from lightstep.b3_propagator import B3Propagator


class RemoteHandler(BaseHTTPRequestHandler):
    """This handler receives the request from the client.
    """

    def do_GET(self):
        server_span = before_answering_request(self, opentracing.tracer)
        with opentracing.tracer.scope_manager.activate(server_span, True):
            server_span.log_event('request received', self.path)

            self.send_response(200)
            self.send_header('Content-type', 'text/html')
            self.end_headers()
            self.wfile.write("Hello World!".encode("utf-8"))

            server_span.log_event('prepared response', self.path)


def before_answering_request(handler, tracer):
    """Context manager creates a Span, using SpanContext encoded in handler if possible.
    """
    operation = 'handle_request:' + handler.path
    carrier_dict = {}
    for k, v in handler.headers.items():
        print('Incoming HEADER', k, v)
        carrier_dict[k] = v
    extracted_context = tracer.extract(opentracing.Format.HTTP_HEADERS, carrier_dict)

    span = None
    if extracted_context:
        span = tracer.start_span(
            operation_name=operation,
            child_of=extracted_context)
    else:
        print('ERROR: Context missing, starting new trace')
        global _exit_code
        _exit_code = errno.ENOMSG
        span = tracer.start_span(operation_name=operation)
        headers = ', '.join({k + '=' + v for k, v in handler.headers.items()})
        span.log_event('extract_failed', headers)
        print('Could not extract context from http headers: ' + headers)

    host, port = handler.client_address
    if host:
        span.set_tag(opentracing.ext.tags.PEER_HOST_IPV4, host)
    if port:
        span.set_tag(opentracing.ext.tags.PEER_PORT, str(port))

    return span


def lightstep_tracer_from_args():
    """Initializes lightstep from the commandline args.
    """
    parser = argparse.ArgumentParser()
    parser.add_argument('--token', help='Your LightStep access token.',
                        default='{your_access_token}')
    parser.add_argument('--host', help='The LightStep reporting service host to contact.',
                        default='collector.lightstep.com')
    parser.add_argument('--port', help='The LightStep reporting service port.',
                        type=int, default=443)
    parser.add_argument('--no_tls', help='Disable TLS for reporting',
                        dest="no_tls", action='store_true')
    parser.add_argument('--component_name', help='The LightStep component name',
                        default='TrivialExample')
    args = parser.parse_args()

    collector_encryption = 'tls'

    return lightstep.Tracer(
        component_name=args.component_name,
        access_token=os.environ['LIGHTSTEP_TOKEN'],
        collector_host=args.host,
        collector_port=args.port,
        collector_encryption=collector_encryption,
    )


if __name__ == '__main__':
    with lightstep_tracer_from_args() as tracer:
        opentracing.tracer = tracer

        opentracing.tracer.register_propagator(Format.TEXT_MAP, B3Propagator())
        opentracing.tracer.register_propagator(
            Format.HTTP_HEADERS, B3Propagator()
        )

        global _exit_code
        _exit_code = 0

        # Create a web server and define the handler to manage the incoming request
        server = HTTPServer(('', 8736), RemoteHandler)

        server.serve_forever()
