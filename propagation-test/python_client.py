#!/usr/bin/env python3

import urllib
import opentracing
import lightstep
import os

def before_sending_request(request):
    """Context manager creates Span and encodes the span's SpanContext into request.
    """
    span = opentracing.tracer.start_span('Sending request')
    span.set_tag('server.http.url', request.get_full_url())
    try:
        # Python 2
        host = request.get_host()
    except:
        # Python 3
        host = request.host

    if host:
        span.set_tag(opentracing.ext.tags.PEER_HOST_IPV4, host)

    carrier_dict = {}
    print("Injecting context\n  trace id: ", span.context.trace_id)
    print("  span id: ", span.context.span_id)
    span.tracer.inject(span.context, opentracing.Format.HTTP_HEADERS, carrier_dict)
    for k, v in carrier_dict.items():
        print(k, v)
        request.add_header(k, v)
    return span

if __name__ == "__main__":
  opentracing.tracer = lightstep.Tracer(
    component_name='hello-python-client',
    access_token=os.environ['LIGHTSTEP_TOKEN'])

  with opentracing.tracer.start_active_span('TestSpan') as scope:
    scope.span.log_event('test message', payload={'life': 42})

    url = 'http://localhost:8080/predictions'
    request = urllib.request.Request(url)
    client_span = before_sending_request(request)
    with opentracing.tracer.scope_manager.activate(client_span, True):
        response = urllib.request.urlopen(request)
        print(response.status)
        print(response.read().decode('utf8'))

  opentracing.tracer.flush()
