// A tracer example using lightstep-tracer-jre and okhttp client
//
// See https://ammonite.io/ on how to install the ammonite repl
//
// $ LIGHTSTEP_TOKEN=<YOUR TOKEN> amm okhttp_client.sc


import $ivy.`com.lightstep.tracer:lightstep-tracer-jre:0.18.0`
import $ivy.`com.lightstep.tracer:tracer-grpc:0.19.0`
import $ivy.`io.grpc:grpc-netty-shaded:1.23.0`
import $ivy.`com.squareup.okhttp3:okhttp:4.3.1`
import $ivy.`io.opentracing.contrib:opentracing-okhttp3:3.0.0`

import scala.util.{Try, Success, Failure}

import com.lightstep.tracer.jre.JRETracer
import com.lightstep.tracer.shared.Options.OptionsBuilder

import okhttp3.OkHttpClient
import okhttp3.Request

import io.opentracing.Span;
import io.opentracing.Tracer;
import io.opentracing.propagation.Format
import io.opentracing.propagation.TextMap
import io.opentracing.contrib.okhttp3.TracingCallFactory


val lightstepToken = sys.env.get("LIGHTSTEP_TOKEN")
  .getOrElse {
    println("LIGHTSTEP_TOKEN not found")
    sys.exit(1)
  }

val tracer = new JRETracer(
  new OptionsBuilder()
    .withAccessToken(lightstepToken)
    .withComponentName("hello-java-client")
    .build()
)

val url = "http://localhost:8736/foo"

val span = tracer.buildSpan("TestSpan").start()

val okHttpClient = new OkHttpClient()
val client = new TracingCallFactory(okHttpClient, tracer)

val request = new Request.Builder().url(url).build();

Try(client.newCall(request).execute()) match {
  case Success(response) =>
    println(response.code)
    println(response.body.string)
  case Failure(e) => println(e)
}

span.finish()
tracer.flush(1000)
