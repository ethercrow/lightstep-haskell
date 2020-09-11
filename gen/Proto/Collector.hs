{- This file was auto-generated from collector.proto by the proto-lens-protoc program. -}
{-# LANGUAGE ScopedTypeVariables, DataKinds, TypeFamilies, UndecidableInstances, GeneralizedNewtypeDeriving, MultiParamTypeClasses, FlexibleContexts, FlexibleInstances, PatternSynonyms, MagicHash, NoImplicitPrelude, DataKinds, BangPatterns, TypeApplications, OverloadedStrings, DerivingStrategies#-}
{-# OPTIONS_GHC -Wno-unused-imports#-}
{-# OPTIONS_GHC -Wno-duplicate-exports#-}
{-# OPTIONS_GHC -Wno-dodgy-exports#-}
module Proto.Collector (
        CollectorService(..), Auth(), Command(), InternalMetrics(),
        KeyValue(), KeyValue'Value(..), _KeyValue'StringValue,
        _KeyValue'IntValue, _KeyValue'DoubleValue, _KeyValue'BoolValue,
        _KeyValue'JsonValue, Log(), MetricsSample(),
        MetricsSample'Value(..), _MetricsSample'IntValue,
        _MetricsSample'DoubleValue, Reference(),
        Reference'Relationship(..), Reference'Relationship(),
        Reference'Relationship'UnrecognizedValue, ReportRequest(),
        ReportResponse(), Reporter(), Span(), SpanContext(),
        SpanContext'BaggageEntry()
    ) where
import qualified Data.ProtoLens.Runtime.Control.DeepSeq as Control.DeepSeq
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Prism as Data.ProtoLens.Prism
import qualified Data.ProtoLens.Runtime.Prelude as Prelude
import qualified Data.ProtoLens.Runtime.Data.Int as Data.Int
import qualified Data.ProtoLens.Runtime.Data.Monoid as Data.Monoid
import qualified Data.ProtoLens.Runtime.Data.Word as Data.Word
import qualified Data.ProtoLens.Runtime.Data.ProtoLens as Data.ProtoLens
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Bytes as Data.ProtoLens.Encoding.Bytes
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Growing as Data.ProtoLens.Encoding.Growing
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Parser.Unsafe as Data.ProtoLens.Encoding.Parser.Unsafe
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Encoding.Wire as Data.ProtoLens.Encoding.Wire
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Field as Data.ProtoLens.Field
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Message.Enum as Data.ProtoLens.Message.Enum
import qualified Data.ProtoLens.Runtime.Data.ProtoLens.Service.Types as Data.ProtoLens.Service.Types
import qualified Data.ProtoLens.Runtime.Lens.Family2 as Lens.Family2
import qualified Data.ProtoLens.Runtime.Lens.Family2.Unchecked as Lens.Family2.Unchecked
import qualified Data.ProtoLens.Runtime.Data.Text as Data.Text
import qualified Data.ProtoLens.Runtime.Data.Map as Data.Map
import qualified Data.ProtoLens.Runtime.Data.ByteString as Data.ByteString
import qualified Data.ProtoLens.Runtime.Data.ByteString.Char8 as Data.ByteString.Char8
import qualified Data.ProtoLens.Runtime.Data.Text.Encoding as Data.Text.Encoding
import qualified Data.ProtoLens.Runtime.Data.Vector as Data.Vector
import qualified Data.ProtoLens.Runtime.Data.Vector.Generic as Data.Vector.Generic
import qualified Data.ProtoLens.Runtime.Data.Vector.Unboxed as Data.Vector.Unboxed
import qualified Data.ProtoLens.Runtime.Text.Read as Text.Read
import qualified Proto.Google.Api.Annotations
import qualified Proto.Google.Protobuf.Timestamp
{- | Fields :
     
         * 'Proto.Collector_Fields.accessToken' @:: Lens' Auth Data.Text.Text@ -}
data Auth
  = Auth'_constructor {_Auth'accessToken :: !Data.Text.Text,
                       _Auth'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Auth where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Auth "accessToken" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Auth'accessToken (\ x__ y__ -> x__ {_Auth'accessToken = y__}))
        Prelude.id
instance Data.ProtoLens.Message Auth where
  messageName _ = Data.Text.pack "lightstep.collector.Auth"
  packedMessageDescriptor _
    = "\n\
      \\EOTAuth\DC2!\n\
      \\faccess_token\CAN\SOH \SOH(\tR\vaccessToken"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        accessToken__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "access_token"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"accessToken")) ::
              Data.ProtoLens.FieldDescriptor Auth
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, accessToken__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Auth'_unknownFields
        (\ x__ y__ -> x__ {_Auth'_unknownFields = y__})
  defMessage
    = Auth'_constructor
        {_Auth'accessToken = Data.ProtoLens.fieldDefault,
         _Auth'_unknownFields = []}
  parseMessage
    = let
        loop :: Auth -> Data.ProtoLens.Encoding.Bytes.Parser Auth
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "access_token"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"accessToken") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Auth"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"accessToken") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             (Data.ProtoLens.Encoding.Wire.buildFieldSet
                (Lens.Family2.view Data.ProtoLens.unknownFields _x))
instance Control.DeepSeq.NFData Auth where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Auth'_unknownFields x__)
             (Control.DeepSeq.deepseq (_Auth'accessToken x__) ())
{- | Fields :
     
         * 'Proto.Collector_Fields.disable' @:: Lens' Command Prelude.Bool@
         * 'Proto.Collector_Fields.devMode' @:: Lens' Command Prelude.Bool@ -}
data Command
  = Command'_constructor {_Command'disable :: !Prelude.Bool,
                          _Command'devMode :: !Prelude.Bool,
                          _Command'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Command where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Command "disable" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'disable (\ x__ y__ -> x__ {_Command'disable = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Command "devMode" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Command'devMode (\ x__ y__ -> x__ {_Command'devMode = y__}))
        Prelude.id
instance Data.ProtoLens.Message Command where
  messageName _ = Data.Text.pack "lightstep.collector.Command"
  packedMessageDescriptor _
    = "\n\
      \\aCommand\DC2\CAN\n\
      \\adisable\CAN\SOH \SOH(\bR\adisable\DC2\EM\n\
      \\bdev_mode\CAN\STX \SOH(\bR\adevMode"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        disable__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "disable"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"disable")) ::
              Data.ProtoLens.FieldDescriptor Command
        devMode__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "dev_mode"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"devMode")) ::
              Data.ProtoLens.FieldDescriptor Command
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, disable__field_descriptor),
           (Data.ProtoLens.Tag 2, devMode__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Command'_unknownFields
        (\ x__ y__ -> x__ {_Command'_unknownFields = y__})
  defMessage
    = Command'_constructor
        {_Command'disable = Data.ProtoLens.fieldDefault,
         _Command'devMode = Data.ProtoLens.fieldDefault,
         _Command'_unknownFields = []}
  parseMessage
    = let
        loop :: Command -> Data.ProtoLens.Encoding.Bytes.Parser Command
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        8 -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "disable"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"disable") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "dev_mode"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"devMode") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Command"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"disable") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      ((Prelude..)
                         Data.ProtoLens.Encoding.Bytes.putVarInt (\ b -> if b then 1 else 0)
                         _v))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"devMode") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 16)
                         ((Prelude..)
                            Data.ProtoLens.Encoding.Bytes.putVarInt (\ b -> if b then 1 else 0)
                            _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData Command where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Command'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Command'disable x__)
                (Control.DeepSeq.deepseq (_Command'devMode x__) ()))
{- | Fields :
     
         * 'Proto.Collector_Fields.startTimestamp' @:: Lens' InternalMetrics Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Collector_Fields.maybe'startTimestamp' @:: Lens' InternalMetrics (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Collector_Fields.durationMicros' @:: Lens' InternalMetrics Data.Word.Word64@
         * 'Proto.Collector_Fields.logs' @:: Lens' InternalMetrics [Log]@
         * 'Proto.Collector_Fields.vec'logs' @:: Lens' InternalMetrics (Data.Vector.Vector Log)@
         * 'Proto.Collector_Fields.counts' @:: Lens' InternalMetrics [MetricsSample]@
         * 'Proto.Collector_Fields.vec'counts' @:: Lens' InternalMetrics (Data.Vector.Vector MetricsSample)@
         * 'Proto.Collector_Fields.gauges' @:: Lens' InternalMetrics [MetricsSample]@
         * 'Proto.Collector_Fields.vec'gauges' @:: Lens' InternalMetrics (Data.Vector.Vector MetricsSample)@ -}
data InternalMetrics
  = InternalMetrics'_constructor {_InternalMetrics'startTimestamp :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                  _InternalMetrics'durationMicros :: !Data.Word.Word64,
                                  _InternalMetrics'logs :: !(Data.Vector.Vector Log),
                                  _InternalMetrics'counts :: !(Data.Vector.Vector MetricsSample),
                                  _InternalMetrics'gauges :: !(Data.Vector.Vector MetricsSample),
                                  _InternalMetrics'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show InternalMetrics where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField InternalMetrics "startTimestamp" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _InternalMetrics'startTimestamp
           (\ x__ y__ -> x__ {_InternalMetrics'startTimestamp = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField InternalMetrics "maybe'startTimestamp" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _InternalMetrics'startTimestamp
           (\ x__ y__ -> x__ {_InternalMetrics'startTimestamp = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField InternalMetrics "durationMicros" Data.Word.Word64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _InternalMetrics'durationMicros
           (\ x__ y__ -> x__ {_InternalMetrics'durationMicros = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField InternalMetrics "logs" [Log] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _InternalMetrics'logs
           (\ x__ y__ -> x__ {_InternalMetrics'logs = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField InternalMetrics "vec'logs" (Data.Vector.Vector Log) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _InternalMetrics'logs
           (\ x__ y__ -> x__ {_InternalMetrics'logs = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField InternalMetrics "counts" [MetricsSample] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _InternalMetrics'counts
           (\ x__ y__ -> x__ {_InternalMetrics'counts = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField InternalMetrics "vec'counts" (Data.Vector.Vector MetricsSample) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _InternalMetrics'counts
           (\ x__ y__ -> x__ {_InternalMetrics'counts = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField InternalMetrics "gauges" [MetricsSample] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _InternalMetrics'gauges
           (\ x__ y__ -> x__ {_InternalMetrics'gauges = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField InternalMetrics "vec'gauges" (Data.Vector.Vector MetricsSample) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _InternalMetrics'gauges
           (\ x__ y__ -> x__ {_InternalMetrics'gauges = y__}))
        Prelude.id
instance Data.ProtoLens.Message InternalMetrics where
  messageName _
    = Data.Text.pack "lightstep.collector.InternalMetrics"
  packedMessageDescriptor _
    = "\n\
      \\SIInternalMetrics\DC2C\n\
      \\SIstart_timestamp\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\SOstartTimestamp\DC2+\n\
      \\SIduration_micros\CAN\STX \SOH(\EOTR\SOdurationMicrosB\STX0\SOH\DC2,\n\
      \\EOTlogs\CAN\ETX \ETX(\v2\CAN.lightstep.collector.LogR\EOTlogs\DC2:\n\
      \\ACKcounts\CAN\EOT \ETX(\v2\".lightstep.collector.MetricsSampleR\ACKcounts\DC2:\n\
      \\ACKgauges\CAN\ENQ \ETX(\v2\".lightstep.collector.MetricsSampleR\ACKgauges"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        startTimestamp__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "start_timestamp"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'startTimestamp")) ::
              Data.ProtoLens.FieldDescriptor InternalMetrics
        durationMicros__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "duration_micros"
              (Data.ProtoLens.ScalarField Data.ProtoLens.UInt64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Word.Word64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"durationMicros")) ::
              Data.ProtoLens.FieldDescriptor InternalMetrics
        logs__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "logs"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Log)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"logs")) ::
              Data.ProtoLens.FieldDescriptor InternalMetrics
        counts__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "counts"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor MetricsSample)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"counts")) ::
              Data.ProtoLens.FieldDescriptor InternalMetrics
        gauges__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "gauges"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor MetricsSample)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"gauges")) ::
              Data.ProtoLens.FieldDescriptor InternalMetrics
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, startTimestamp__field_descriptor),
           (Data.ProtoLens.Tag 2, durationMicros__field_descriptor),
           (Data.ProtoLens.Tag 3, logs__field_descriptor),
           (Data.ProtoLens.Tag 4, counts__field_descriptor),
           (Data.ProtoLens.Tag 5, gauges__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _InternalMetrics'_unknownFields
        (\ x__ y__ -> x__ {_InternalMetrics'_unknownFields = y__})
  defMessage
    = InternalMetrics'_constructor
        {_InternalMetrics'startTimestamp = Prelude.Nothing,
         _InternalMetrics'durationMicros = Data.ProtoLens.fieldDefault,
         _InternalMetrics'logs = Data.Vector.Generic.empty,
         _InternalMetrics'counts = Data.Vector.Generic.empty,
         _InternalMetrics'gauges = Data.Vector.Generic.empty,
         _InternalMetrics'_unknownFields = []}
  parseMessage
    = let
        loop ::
          InternalMetrics
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld MetricsSample
             -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld MetricsSample
                -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Log
                   -> Data.ProtoLens.Encoding.Bytes.Parser InternalMetrics
        loop x mutable'counts mutable'gauges mutable'logs
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'counts <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                         (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                            mutable'counts)
                      frozen'gauges <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                         (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                            mutable'gauges)
                      frozen'logs <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.unsafeFreeze mutable'logs)
                      (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t)
                           (Lens.Family2.set
                              (Data.ProtoLens.Field.field @"vec'counts") frozen'counts
                              (Lens.Family2.set
                                 (Data.ProtoLens.Field.field @"vec'gauges") frozen'gauges
                                 (Lens.Family2.set
                                    (Data.ProtoLens.Field.field @"vec'logs") frozen'logs x))))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "start_timestamp"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"startTimestamp") y x)
                                  mutable'counts mutable'gauges mutable'logs
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       Data.ProtoLens.Encoding.Bytes.getVarInt "duration_micros"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"durationMicros") y x)
                                  mutable'counts mutable'gauges mutable'logs
                        26
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "logs"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'logs y)
                                loop x mutable'counts mutable'gauges v
                        34
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "counts"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'counts y)
                                loop x v mutable'gauges mutable'logs
                        42
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "gauges"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'gauges y)
                                loop x mutable'counts v mutable'logs
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'counts mutable'gauges mutable'logs
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'counts <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                  Data.ProtoLens.Encoding.Growing.new
              mutable'gauges <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                  Data.ProtoLens.Encoding.Growing.new
              mutable'logs <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                Data.ProtoLens.Encoding.Growing.new
              loop
                Data.ProtoLens.defMessage mutable'counts mutable'gauges
                mutable'logs)
          "InternalMetrics"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'startTimestamp") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just _v)
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage _v))
             ((Data.Monoid.<>)
                (let
                   _v
                     = Lens.Family2.view
                         (Data.ProtoLens.Field.field @"durationMicros") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 16)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt _v))
                ((Data.Monoid.<>)
                   (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                      (\ _v
                         -> (Data.Monoid.<>)
                              (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                              ((Prelude..)
                                 (\ bs
                                    -> (Data.Monoid.<>)
                                         (Data.ProtoLens.Encoding.Bytes.putVarInt
                                            (Prelude.fromIntegral (Data.ByteString.length bs)))
                                         (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                 Data.ProtoLens.encodeMessage _v))
                      (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'logs") _x))
                   ((Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                         (\ _v
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                                 ((Prelude..)
                                    (\ bs
                                       -> (Data.Monoid.<>)
                                            (Data.ProtoLens.Encoding.Bytes.putVarInt
                                               (Prelude.fromIntegral (Data.ByteString.length bs)))
                                            (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                    Data.ProtoLens.encodeMessage _v))
                         (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'counts") _x))
                      ((Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                            (\ _v
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
                                    ((Prelude..)
                                       (\ bs
                                          -> (Data.Monoid.<>)
                                               (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                  (Prelude.fromIntegral
                                                     (Data.ByteString.length bs)))
                                               (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                       Data.ProtoLens.encodeMessage _v))
                            (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'gauges") _x))
                         (Data.ProtoLens.Encoding.Wire.buildFieldSet
                            (Lens.Family2.view Data.ProtoLens.unknownFields _x))))))
instance Control.DeepSeq.NFData InternalMetrics where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_InternalMetrics'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_InternalMetrics'startTimestamp x__)
                (Control.DeepSeq.deepseq
                   (_InternalMetrics'durationMicros x__)
                   (Control.DeepSeq.deepseq
                      (_InternalMetrics'logs x__)
                      (Control.DeepSeq.deepseq
                         (_InternalMetrics'counts x__)
                         (Control.DeepSeq.deepseq (_InternalMetrics'gauges x__) ())))))
{- | Fields :
     
         * 'Proto.Collector_Fields.key' @:: Lens' KeyValue Data.Text.Text@
         * 'Proto.Collector_Fields.maybe'value' @:: Lens' KeyValue (Prelude.Maybe KeyValue'Value)@
         * 'Proto.Collector_Fields.maybe'stringValue' @:: Lens' KeyValue (Prelude.Maybe Data.Text.Text)@
         * 'Proto.Collector_Fields.stringValue' @:: Lens' KeyValue Data.Text.Text@
         * 'Proto.Collector_Fields.maybe'intValue' @:: Lens' KeyValue (Prelude.Maybe Data.Int.Int64)@
         * 'Proto.Collector_Fields.intValue' @:: Lens' KeyValue Data.Int.Int64@
         * 'Proto.Collector_Fields.maybe'doubleValue' @:: Lens' KeyValue (Prelude.Maybe Prelude.Double)@
         * 'Proto.Collector_Fields.doubleValue' @:: Lens' KeyValue Prelude.Double@
         * 'Proto.Collector_Fields.maybe'boolValue' @:: Lens' KeyValue (Prelude.Maybe Prelude.Bool)@
         * 'Proto.Collector_Fields.boolValue' @:: Lens' KeyValue Prelude.Bool@
         * 'Proto.Collector_Fields.maybe'jsonValue' @:: Lens' KeyValue (Prelude.Maybe Data.Text.Text)@
         * 'Proto.Collector_Fields.jsonValue' @:: Lens' KeyValue Data.Text.Text@ -}
data KeyValue
  = KeyValue'_constructor {_KeyValue'key :: !Data.Text.Text,
                           _KeyValue'value :: !(Prelude.Maybe KeyValue'Value),
                           _KeyValue'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show KeyValue where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data KeyValue'Value
  = KeyValue'StringValue !Data.Text.Text |
    KeyValue'IntValue !Data.Int.Int64 |
    KeyValue'DoubleValue !Prelude.Double |
    KeyValue'BoolValue !Prelude.Bool |
    KeyValue'JsonValue !Data.Text.Text
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField KeyValue "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _KeyValue'key (\ x__ y__ -> x__ {_KeyValue'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField KeyValue "maybe'value" (Prelude.Maybe KeyValue'Value) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _KeyValue'value (\ x__ y__ -> x__ {_KeyValue'value = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField KeyValue "maybe'stringValue" (Prelude.Maybe Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _KeyValue'value (\ x__ y__ -> x__ {_KeyValue'value = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (KeyValue'StringValue x__val)) -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap KeyValue'StringValue y__))
instance Data.ProtoLens.Field.HasField KeyValue "stringValue" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _KeyValue'value (\ x__ y__ -> x__ {_KeyValue'value = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (KeyValue'StringValue x__val)) -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap KeyValue'StringValue y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))
instance Data.ProtoLens.Field.HasField KeyValue "maybe'intValue" (Prelude.Maybe Data.Int.Int64) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _KeyValue'value (\ x__ y__ -> x__ {_KeyValue'value = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (KeyValue'IntValue x__val)) -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap KeyValue'IntValue y__))
instance Data.ProtoLens.Field.HasField KeyValue "intValue" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _KeyValue'value (\ x__ y__ -> x__ {_KeyValue'value = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (KeyValue'IntValue x__val)) -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap KeyValue'IntValue y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))
instance Data.ProtoLens.Field.HasField KeyValue "maybe'doubleValue" (Prelude.Maybe Prelude.Double) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _KeyValue'value (\ x__ y__ -> x__ {_KeyValue'value = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (KeyValue'DoubleValue x__val)) -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap KeyValue'DoubleValue y__))
instance Data.ProtoLens.Field.HasField KeyValue "doubleValue" Prelude.Double where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _KeyValue'value (\ x__ y__ -> x__ {_KeyValue'value = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (KeyValue'DoubleValue x__val)) -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap KeyValue'DoubleValue y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))
instance Data.ProtoLens.Field.HasField KeyValue "maybe'boolValue" (Prelude.Maybe Prelude.Bool) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _KeyValue'value (\ x__ y__ -> x__ {_KeyValue'value = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (KeyValue'BoolValue x__val)) -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap KeyValue'BoolValue y__))
instance Data.ProtoLens.Field.HasField KeyValue "boolValue" Prelude.Bool where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _KeyValue'value (\ x__ y__ -> x__ {_KeyValue'value = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (KeyValue'BoolValue x__val)) -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap KeyValue'BoolValue y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))
instance Data.ProtoLens.Field.HasField KeyValue "maybe'jsonValue" (Prelude.Maybe Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _KeyValue'value (\ x__ y__ -> x__ {_KeyValue'value = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (KeyValue'JsonValue x__val)) -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap KeyValue'JsonValue y__))
instance Data.ProtoLens.Field.HasField KeyValue "jsonValue" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _KeyValue'value (\ x__ y__ -> x__ {_KeyValue'value = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (KeyValue'JsonValue x__val)) -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap KeyValue'JsonValue y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))
instance Data.ProtoLens.Message KeyValue where
  messageName _ = Data.Text.pack "lightstep.collector.KeyValue"
  packedMessageDescriptor _
    = "\n\
      \\bKeyValue\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2#\n\
      \\fstring_value\CAN\STX \SOH(\tH\NULR\vstringValue\DC2!\n\
      \\tint_value\CAN\ETX \SOH(\ETXH\NULR\bintValueB\STX0\SOH\DC2#\n\
      \\fdouble_value\CAN\EOT \SOH(\SOHH\NULR\vdoubleValue\DC2\US\n\
      \\n\
      \bool_value\CAN\ENQ \SOH(\bH\NULR\tboolValue\DC2\US\n\
      \\n\
      \json_value\CAN\ACK \SOH(\tH\NULR\tjsonValueB\a\n\
      \\ENQvalue"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        key__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "key"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"key")) ::
              Data.ProtoLens.FieldDescriptor KeyValue
        stringValue__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "string_value"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'stringValue")) ::
              Data.ProtoLens.FieldDescriptor KeyValue
        intValue__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "int_value"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'intValue")) ::
              Data.ProtoLens.FieldDescriptor KeyValue
        doubleValue__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "double_value"
              (Data.ProtoLens.ScalarField Data.ProtoLens.DoubleField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Double)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'doubleValue")) ::
              Data.ProtoLens.FieldDescriptor KeyValue
        boolValue__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "bool_value"
              (Data.ProtoLens.ScalarField Data.ProtoLens.BoolField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Bool)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'boolValue")) ::
              Data.ProtoLens.FieldDescriptor KeyValue
        jsonValue__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "json_value"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'jsonValue")) ::
              Data.ProtoLens.FieldDescriptor KeyValue
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, stringValue__field_descriptor),
           (Data.ProtoLens.Tag 3, intValue__field_descriptor),
           (Data.ProtoLens.Tag 4, doubleValue__field_descriptor),
           (Data.ProtoLens.Tag 5, boolValue__field_descriptor),
           (Data.ProtoLens.Tag 6, jsonValue__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _KeyValue'_unknownFields
        (\ x__ y__ -> x__ {_KeyValue'_unknownFields = y__})
  defMessage
    = KeyValue'_constructor
        {_KeyValue'key = Data.ProtoLens.fieldDefault,
         _KeyValue'value = Prelude.Nothing, _KeyValue'_unknownFields = []}
  parseMessage
    = let
        loop :: KeyValue -> Data.ProtoLens.Encoding.Bytes.Parser KeyValue
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "key"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"key") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "string_value"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"stringValue") y x)
                        24
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "int_value"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"intValue") y x)
                        33
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Data.ProtoLens.Encoding.Bytes.wordToDouble
                                          Data.ProtoLens.Encoding.Bytes.getFixed64)
                                       "double_value"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"doubleValue") y x)
                        40
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          ((Prelude./=) 0) Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "bool_value"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"boolValue") y x)
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "json_value"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"jsonValue") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "KeyValue"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"key") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (case
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'value") _x
                 of
                   Prelude.Nothing -> Data.Monoid.mempty
                   (Prelude.Just (KeyValue'StringValue v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.Text.Encoding.encodeUtf8 v)
                   (Prelude.Just (KeyValue'IntValue v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 24)
                          ((Prelude..)
                             Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral v)
                   (Prelude.Just (KeyValue'DoubleValue v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 33)
                          ((Prelude..)
                             Data.ProtoLens.Encoding.Bytes.putFixed64
                             Data.ProtoLens.Encoding.Bytes.doubleToWord v)
                   (Prelude.Just (KeyValue'BoolValue v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 40)
                          ((Prelude..)
                             Data.ProtoLens.Encoding.Bytes.putVarInt (\ b -> if b then 1 else 0)
                             v)
                   (Prelude.Just (KeyValue'JsonValue v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.Text.Encoding.encodeUtf8 v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData KeyValue where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_KeyValue'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_KeyValue'key x__)
                (Control.DeepSeq.deepseq (_KeyValue'value x__) ()))
instance Control.DeepSeq.NFData KeyValue'Value where
  rnf (KeyValue'StringValue x__) = Control.DeepSeq.rnf x__
  rnf (KeyValue'IntValue x__) = Control.DeepSeq.rnf x__
  rnf (KeyValue'DoubleValue x__) = Control.DeepSeq.rnf x__
  rnf (KeyValue'BoolValue x__) = Control.DeepSeq.rnf x__
  rnf (KeyValue'JsonValue x__) = Control.DeepSeq.rnf x__
_KeyValue'StringValue ::
  Data.ProtoLens.Prism.Prism' KeyValue'Value Data.Text.Text
_KeyValue'StringValue
  = Data.ProtoLens.Prism.prism'
      KeyValue'StringValue
      (\ p__
         -> case p__ of
              (KeyValue'StringValue p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_KeyValue'IntValue ::
  Data.ProtoLens.Prism.Prism' KeyValue'Value Data.Int.Int64
_KeyValue'IntValue
  = Data.ProtoLens.Prism.prism'
      KeyValue'IntValue
      (\ p__
         -> case p__ of
              (KeyValue'IntValue p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_KeyValue'DoubleValue ::
  Data.ProtoLens.Prism.Prism' KeyValue'Value Prelude.Double
_KeyValue'DoubleValue
  = Data.ProtoLens.Prism.prism'
      KeyValue'DoubleValue
      (\ p__
         -> case p__ of
              (KeyValue'DoubleValue p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_KeyValue'BoolValue ::
  Data.ProtoLens.Prism.Prism' KeyValue'Value Prelude.Bool
_KeyValue'BoolValue
  = Data.ProtoLens.Prism.prism'
      KeyValue'BoolValue
      (\ p__
         -> case p__ of
              (KeyValue'BoolValue p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_KeyValue'JsonValue ::
  Data.ProtoLens.Prism.Prism' KeyValue'Value Data.Text.Text
_KeyValue'JsonValue
  = Data.ProtoLens.Prism.prism'
      KeyValue'JsonValue
      (\ p__
         -> case p__ of
              (KeyValue'JsonValue p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
{- | Fields :
     
         * 'Proto.Collector_Fields.timestamp' @:: Lens' Log Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Collector_Fields.maybe'timestamp' @:: Lens' Log (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Collector_Fields.fields' @:: Lens' Log [KeyValue]@
         * 'Proto.Collector_Fields.vec'fields' @:: Lens' Log (Data.Vector.Vector KeyValue)@ -}
data Log
  = Log'_constructor {_Log'timestamp :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                      _Log'fields :: !(Data.Vector.Vector KeyValue),
                      _Log'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Log where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Log "timestamp" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Log'timestamp (\ x__ y__ -> x__ {_Log'timestamp = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Log "maybe'timestamp" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Log'timestamp (\ x__ y__ -> x__ {_Log'timestamp = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Log "fields" [KeyValue] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Log'fields (\ x__ y__ -> x__ {_Log'fields = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField Log "vec'fields" (Data.Vector.Vector KeyValue) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Log'fields (\ x__ y__ -> x__ {_Log'fields = y__}))
        Prelude.id
instance Data.ProtoLens.Message Log where
  messageName _ = Data.Text.pack "lightstep.collector.Log"
  packedMessageDescriptor _
    = "\n\
      \\ETXLog\DC28\n\
      \\ttimestamp\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\ttimestamp\DC25\n\
      \\ACKfields\CAN\STX \ETX(\v2\GS.lightstep.collector.KeyValueR\ACKfields"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        timestamp__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "timestamp"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'timestamp")) ::
              Data.ProtoLens.FieldDescriptor Log
        fields__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "fields"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor KeyValue)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"fields")) ::
              Data.ProtoLens.FieldDescriptor Log
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, timestamp__field_descriptor),
           (Data.ProtoLens.Tag 2, fields__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Log'_unknownFields (\ x__ y__ -> x__ {_Log'_unknownFields = y__})
  defMessage
    = Log'_constructor
        {_Log'timestamp = Prelude.Nothing,
         _Log'fields = Data.Vector.Generic.empty, _Log'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Log
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld KeyValue
             -> Data.ProtoLens.Encoding.Bytes.Parser Log
        loop x mutable'fields
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'fields <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                         (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                            mutable'fields)
                      (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t)
                           (Lens.Family2.set
                              (Data.ProtoLens.Field.field @"vec'fields") frozen'fields x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "timestamp"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"timestamp") y x)
                                  mutable'fields
                        18
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "fields"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'fields y)
                                loop x v
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'fields
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'fields <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                  Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'fields)
          "Log"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'timestamp") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just _v)
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage _v))
             ((Data.Monoid.<>)
                (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                   (\ _v
                      -> (Data.Monoid.<>)
                           (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                           ((Prelude..)
                              (\ bs
                                 -> (Data.Monoid.<>)
                                      (Data.ProtoLens.Encoding.Bytes.putVarInt
                                         (Prelude.fromIntegral (Data.ByteString.length bs)))
                                      (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                              Data.ProtoLens.encodeMessage _v))
                   (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'fields") _x))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData Log where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Log'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Log'timestamp x__)
                (Control.DeepSeq.deepseq (_Log'fields x__) ()))
{- | Fields :
     
         * 'Proto.Collector_Fields.name' @:: Lens' MetricsSample Data.Text.Text@
         * 'Proto.Collector_Fields.maybe'value' @:: Lens' MetricsSample (Prelude.Maybe MetricsSample'Value)@
         * 'Proto.Collector_Fields.maybe'intValue' @:: Lens' MetricsSample (Prelude.Maybe Data.Int.Int64)@
         * 'Proto.Collector_Fields.intValue' @:: Lens' MetricsSample Data.Int.Int64@
         * 'Proto.Collector_Fields.maybe'doubleValue' @:: Lens' MetricsSample (Prelude.Maybe Prelude.Double)@
         * 'Proto.Collector_Fields.doubleValue' @:: Lens' MetricsSample Prelude.Double@ -}
data MetricsSample
  = MetricsSample'_constructor {_MetricsSample'name :: !Data.Text.Text,
                                _MetricsSample'value :: !(Prelude.Maybe MetricsSample'Value),
                                _MetricsSample'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show MetricsSample where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
data MetricsSample'Value
  = MetricsSample'IntValue !Data.Int.Int64 |
    MetricsSample'DoubleValue !Prelude.Double
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.Field.HasField MetricsSample "name" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _MetricsSample'name (\ x__ y__ -> x__ {_MetricsSample'name = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField MetricsSample "maybe'value" (Prelude.Maybe MetricsSample'Value) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _MetricsSample'value
           (\ x__ y__ -> x__ {_MetricsSample'value = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField MetricsSample "maybe'intValue" (Prelude.Maybe Data.Int.Int64) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _MetricsSample'value
           (\ x__ y__ -> x__ {_MetricsSample'value = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (MetricsSample'IntValue x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap MetricsSample'IntValue y__))
instance Data.ProtoLens.Field.HasField MetricsSample "intValue" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _MetricsSample'value
           (\ x__ y__ -> x__ {_MetricsSample'value = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (MetricsSample'IntValue x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap MetricsSample'IntValue y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))
instance Data.ProtoLens.Field.HasField MetricsSample "maybe'doubleValue" (Prelude.Maybe Prelude.Double) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _MetricsSample'value
           (\ x__ y__ -> x__ {_MetricsSample'value = y__}))
        (Lens.Family2.Unchecked.lens
           (\ x__
              -> case x__ of
                   (Prelude.Just (MetricsSample'DoubleValue x__val))
                     -> Prelude.Just x__val
                   _otherwise -> Prelude.Nothing)
           (\ _ y__ -> Prelude.fmap MetricsSample'DoubleValue y__))
instance Data.ProtoLens.Field.HasField MetricsSample "doubleValue" Prelude.Double where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _MetricsSample'value
           (\ x__ y__ -> x__ {_MetricsSample'value = y__}))
        ((Prelude..)
           (Lens.Family2.Unchecked.lens
              (\ x__
                 -> case x__ of
                      (Prelude.Just (MetricsSample'DoubleValue x__val))
                        -> Prelude.Just x__val
                      _otherwise -> Prelude.Nothing)
              (\ _ y__ -> Prelude.fmap MetricsSample'DoubleValue y__))
           (Data.ProtoLens.maybeLens Data.ProtoLens.fieldDefault))
instance Data.ProtoLens.Message MetricsSample where
  messageName _ = Data.Text.pack "lightstep.collector.MetricsSample"
  packedMessageDescriptor _
    = "\n\
      \\rMetricsSample\DC2\DC2\n\
      \\EOTname\CAN\SOH \SOH(\tR\EOTname\DC2!\n\
      \\tint_value\CAN\STX \SOH(\ETXH\NULR\bintValueB\STX0\SOH\DC2#\n\
      \\fdouble_value\CAN\ETX \SOH(\SOHH\NULR\vdoubleValueB\a\n\
      \\ENQvalue"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        name__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"name")) ::
              Data.ProtoLens.FieldDescriptor MetricsSample
        intValue__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "int_value"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'intValue")) ::
              Data.ProtoLens.FieldDescriptor MetricsSample
        doubleValue__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "double_value"
              (Data.ProtoLens.ScalarField Data.ProtoLens.DoubleField ::
                 Data.ProtoLens.FieldTypeDescriptor Prelude.Double)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'doubleValue")) ::
              Data.ProtoLens.FieldDescriptor MetricsSample
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, name__field_descriptor),
           (Data.ProtoLens.Tag 2, intValue__field_descriptor),
           (Data.ProtoLens.Tag 3, doubleValue__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _MetricsSample'_unknownFields
        (\ x__ y__ -> x__ {_MetricsSample'_unknownFields = y__})
  defMessage
    = MetricsSample'_constructor
        {_MetricsSample'name = Data.ProtoLens.fieldDefault,
         _MetricsSample'value = Prelude.Nothing,
         _MetricsSample'_unknownFields = []}
  parseMessage
    = let
        loop ::
          MetricsSample -> Data.ProtoLens.Encoding.Bytes.Parser MetricsSample
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "name"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"name") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "int_value"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"intValue") y x)
                        25
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Data.ProtoLens.Encoding.Bytes.wordToDouble
                                          Data.ProtoLens.Encoding.Bytes.getFixed64)
                                       "double_value"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"doubleValue") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "MetricsSample"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"name") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (case
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'value") _x
                 of
                   Prelude.Nothing -> Data.Monoid.mempty
                   (Prelude.Just (MetricsSample'IntValue v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 16)
                          ((Prelude..)
                             Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral v)
                   (Prelude.Just (MetricsSample'DoubleValue v))
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 25)
                          ((Prelude..)
                             Data.ProtoLens.Encoding.Bytes.putFixed64
                             Data.ProtoLens.Encoding.Bytes.doubleToWord v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData MetricsSample where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_MetricsSample'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_MetricsSample'name x__)
                (Control.DeepSeq.deepseq (_MetricsSample'value x__) ()))
instance Control.DeepSeq.NFData MetricsSample'Value where
  rnf (MetricsSample'IntValue x__) = Control.DeepSeq.rnf x__
  rnf (MetricsSample'DoubleValue x__) = Control.DeepSeq.rnf x__
_MetricsSample'IntValue ::
  Data.ProtoLens.Prism.Prism' MetricsSample'Value Data.Int.Int64
_MetricsSample'IntValue
  = Data.ProtoLens.Prism.prism'
      MetricsSample'IntValue
      (\ p__
         -> case p__ of
              (MetricsSample'IntValue p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
_MetricsSample'DoubleValue ::
  Data.ProtoLens.Prism.Prism' MetricsSample'Value Prelude.Double
_MetricsSample'DoubleValue
  = Data.ProtoLens.Prism.prism'
      MetricsSample'DoubleValue
      (\ p__
         -> case p__ of
              (MetricsSample'DoubleValue p__val) -> Prelude.Just p__val
              _otherwise -> Prelude.Nothing)
{- | Fields :
     
         * 'Proto.Collector_Fields.relationship' @:: Lens' Reference Reference'Relationship@
         * 'Proto.Collector_Fields.spanContext' @:: Lens' Reference SpanContext@
         * 'Proto.Collector_Fields.maybe'spanContext' @:: Lens' Reference (Prelude.Maybe SpanContext)@ -}
data Reference
  = Reference'_constructor {_Reference'relationship :: !Reference'Relationship,
                            _Reference'spanContext :: !(Prelude.Maybe SpanContext),
                            _Reference'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Reference where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Reference "relationship" Reference'Relationship where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Reference'relationship
           (\ x__ y__ -> x__ {_Reference'relationship = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Reference "spanContext" SpanContext where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Reference'spanContext
           (\ x__ y__ -> x__ {_Reference'spanContext = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Reference "maybe'spanContext" (Prelude.Maybe SpanContext) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Reference'spanContext
           (\ x__ y__ -> x__ {_Reference'spanContext = y__}))
        Prelude.id
instance Data.ProtoLens.Message Reference where
  messageName _ = Data.Text.pack "lightstep.collector.Reference"
  packedMessageDescriptor _
    = "\n\
      \\tReference\DC2O\n\
      \\frelationship\CAN\SOH \SOH(\SO2+.lightstep.collector.Reference.RelationshipR\frelationship\DC2C\n\
      \\fspan_context\CAN\STX \SOH(\v2 .lightstep.collector.SpanContextR\vspanContext\".\n\
      \\fRelationship\DC2\f\n\
      \\bCHILD_OF\DLE\NUL\DC2\DLE\n\
      \\fFOLLOWS_FROM\DLE\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        relationship__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "relationship"
              (Data.ProtoLens.ScalarField Data.ProtoLens.EnumField ::
                 Data.ProtoLens.FieldTypeDescriptor Reference'Relationship)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"relationship")) ::
              Data.ProtoLens.FieldDescriptor Reference
        spanContext__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "span_context"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor SpanContext)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'spanContext")) ::
              Data.ProtoLens.FieldDescriptor Reference
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, relationship__field_descriptor),
           (Data.ProtoLens.Tag 2, spanContext__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Reference'_unknownFields
        (\ x__ y__ -> x__ {_Reference'_unknownFields = y__})
  defMessage
    = Reference'_constructor
        {_Reference'relationship = Data.ProtoLens.fieldDefault,
         _Reference'spanContext = Prelude.Nothing,
         _Reference'_unknownFields = []}
  parseMessage
    = let
        loop :: Reference -> Data.ProtoLens.Encoding.Bytes.Parser Reference
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        8 -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.toEnum
                                          (Prelude.fmap
                                             Prelude.fromIntegral
                                             Data.ProtoLens.Encoding.Bytes.getVarInt))
                                       "relationship"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"relationship") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "span_context"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"spanContext") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "Reference"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"relationship") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      ((Prelude..)
                         ((Prelude..)
                            Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral)
                         Prelude.fromEnum _v))
             ((Data.Monoid.<>)
                (case
                     Lens.Family2.view
                       (Data.ProtoLens.Field.field @"maybe'spanContext") _x
                 of
                   Prelude.Nothing -> Data.Monoid.mempty
                   (Prelude.Just _v)
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData Reference where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Reference'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Reference'relationship x__)
                (Control.DeepSeq.deepseq (_Reference'spanContext x__) ()))
newtype Reference'Relationship'UnrecognizedValue
  = Reference'Relationship'UnrecognizedValue Data.Int.Int32
  deriving stock (Prelude.Eq, Prelude.Ord, Prelude.Show)
data Reference'Relationship
  = Reference'CHILD_OF |
    Reference'FOLLOWS_FROM |
    Reference'Relationship'Unrecognized !Reference'Relationship'UnrecognizedValue
  deriving stock (Prelude.Show, Prelude.Eq, Prelude.Ord)
instance Data.ProtoLens.MessageEnum Reference'Relationship where
  maybeToEnum 0 = Prelude.Just Reference'CHILD_OF
  maybeToEnum 1 = Prelude.Just Reference'FOLLOWS_FROM
  maybeToEnum k
    = Prelude.Just
        (Reference'Relationship'Unrecognized
           (Reference'Relationship'UnrecognizedValue
              (Prelude.fromIntegral k)))
  showEnum Reference'CHILD_OF = "CHILD_OF"
  showEnum Reference'FOLLOWS_FROM = "FOLLOWS_FROM"
  showEnum
    (Reference'Relationship'Unrecognized (Reference'Relationship'UnrecognizedValue k))
    = Prelude.show k
  readEnum k
    | (Prelude.==) k "CHILD_OF" = Prelude.Just Reference'CHILD_OF
    | (Prelude.==) k "FOLLOWS_FROM"
    = Prelude.Just Reference'FOLLOWS_FROM
    | Prelude.otherwise
    = (Prelude.>>=) (Text.Read.readMaybe k) Data.ProtoLens.maybeToEnum
instance Prelude.Bounded Reference'Relationship where
  minBound = Reference'CHILD_OF
  maxBound = Reference'FOLLOWS_FROM
instance Prelude.Enum Reference'Relationship where
  toEnum k__
    = Prelude.maybe
        (Prelude.error
           ((Prelude.++)
              "toEnum: unknown value for enum Relationship: "
              (Prelude.show k__)))
        Prelude.id (Data.ProtoLens.maybeToEnum k__)
  fromEnum Reference'CHILD_OF = 0
  fromEnum Reference'FOLLOWS_FROM = 1
  fromEnum
    (Reference'Relationship'Unrecognized (Reference'Relationship'UnrecognizedValue k))
    = Prelude.fromIntegral k
  succ Reference'FOLLOWS_FROM
    = Prelude.error
        "Reference'Relationship.succ: bad argument Reference'FOLLOWS_FROM. This value would be out of bounds."
  succ Reference'CHILD_OF = Reference'FOLLOWS_FROM
  succ (Reference'Relationship'Unrecognized _)
    = Prelude.error
        "Reference'Relationship.succ: bad argument: unrecognized value"
  pred Reference'CHILD_OF
    = Prelude.error
        "Reference'Relationship.pred: bad argument Reference'CHILD_OF. This value would be out of bounds."
  pred Reference'FOLLOWS_FROM = Reference'CHILD_OF
  pred (Reference'Relationship'Unrecognized _)
    = Prelude.error
        "Reference'Relationship.pred: bad argument: unrecognized value"
  enumFrom = Data.ProtoLens.Message.Enum.messageEnumFrom
  enumFromTo = Data.ProtoLens.Message.Enum.messageEnumFromTo
  enumFromThen = Data.ProtoLens.Message.Enum.messageEnumFromThen
  enumFromThenTo = Data.ProtoLens.Message.Enum.messageEnumFromThenTo
instance Data.ProtoLens.FieldDefault Reference'Relationship where
  fieldDefault = Reference'CHILD_OF
instance Control.DeepSeq.NFData Reference'Relationship where
  rnf x__ = Prelude.seq x__ ()
{- | Fields :
     
         * 'Proto.Collector_Fields.reporter' @:: Lens' ReportRequest Reporter@
         * 'Proto.Collector_Fields.maybe'reporter' @:: Lens' ReportRequest (Prelude.Maybe Reporter)@
         * 'Proto.Collector_Fields.auth' @:: Lens' ReportRequest Auth@
         * 'Proto.Collector_Fields.maybe'auth' @:: Lens' ReportRequest (Prelude.Maybe Auth)@
         * 'Proto.Collector_Fields.spans' @:: Lens' ReportRequest [Span]@
         * 'Proto.Collector_Fields.vec'spans' @:: Lens' ReportRequest (Data.Vector.Vector Span)@
         * 'Proto.Collector_Fields.timestampOffsetMicros' @:: Lens' ReportRequest Data.Int.Int64@
         * 'Proto.Collector_Fields.internalMetrics' @:: Lens' ReportRequest InternalMetrics@
         * 'Proto.Collector_Fields.maybe'internalMetrics' @:: Lens' ReportRequest (Prelude.Maybe InternalMetrics)@ -}
data ReportRequest
  = ReportRequest'_constructor {_ReportRequest'reporter :: !(Prelude.Maybe Reporter),
                                _ReportRequest'auth :: !(Prelude.Maybe Auth),
                                _ReportRequest'spans :: !(Data.Vector.Vector Span),
                                _ReportRequest'timestampOffsetMicros :: !Data.Int.Int64,
                                _ReportRequest'internalMetrics :: !(Prelude.Maybe InternalMetrics),
                                _ReportRequest'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ReportRequest where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ReportRequest "reporter" Reporter where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReportRequest'reporter
           (\ x__ y__ -> x__ {_ReportRequest'reporter = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ReportRequest "maybe'reporter" (Prelude.Maybe Reporter) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReportRequest'reporter
           (\ x__ y__ -> x__ {_ReportRequest'reporter = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ReportRequest "auth" Auth where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReportRequest'auth (\ x__ y__ -> x__ {_ReportRequest'auth = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ReportRequest "maybe'auth" (Prelude.Maybe Auth) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReportRequest'auth (\ x__ y__ -> x__ {_ReportRequest'auth = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ReportRequest "spans" [Span] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReportRequest'spans
           (\ x__ y__ -> x__ {_ReportRequest'spans = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField ReportRequest "vec'spans" (Data.Vector.Vector Span) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReportRequest'spans
           (\ x__ y__ -> x__ {_ReportRequest'spans = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ReportRequest "timestampOffsetMicros" Data.Int.Int64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReportRequest'timestampOffsetMicros
           (\ x__ y__ -> x__ {_ReportRequest'timestampOffsetMicros = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ReportRequest "internalMetrics" InternalMetrics where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReportRequest'internalMetrics
           (\ x__ y__ -> x__ {_ReportRequest'internalMetrics = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ReportRequest "maybe'internalMetrics" (Prelude.Maybe InternalMetrics) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReportRequest'internalMetrics
           (\ x__ y__ -> x__ {_ReportRequest'internalMetrics = y__}))
        Prelude.id
instance Data.ProtoLens.Message ReportRequest where
  messageName _ = Data.Text.pack "lightstep.collector.ReportRequest"
  packedMessageDescriptor _
    = "\n\
      \\rReportRequest\DC29\n\
      \\breporter\CAN\SOH \SOH(\v2\GS.lightstep.collector.ReporterR\breporter\DC2-\n\
      \\EOTauth\CAN\STX \SOH(\v2\EM.lightstep.collector.AuthR\EOTauth\DC2/\n\
      \\ENQspans\CAN\ETX \ETX(\v2\EM.lightstep.collector.SpanR\ENQspans\DC2:\n\
      \\ETBtimestamp_offset_micros\CAN\ENQ \SOH(\ETXR\NAKtimestampOffsetMicrosB\STX0\SOH\DC2O\n\
      \\DLEinternal_metrics\CAN\ACK \SOH(\v2$.lightstep.collector.InternalMetricsR\SIinternalMetrics"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        reporter__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "reporter"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Reporter)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'reporter")) ::
              Data.ProtoLens.FieldDescriptor ReportRequest
        auth__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "auth"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Auth)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'auth")) ::
              Data.ProtoLens.FieldDescriptor ReportRequest
        spans__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "spans"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Span)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"spans")) ::
              Data.ProtoLens.FieldDescriptor ReportRequest
        timestampOffsetMicros__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "timestamp_offset_micros"
              (Data.ProtoLens.ScalarField Data.ProtoLens.Int64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Int.Int64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"timestampOffsetMicros")) ::
              Data.ProtoLens.FieldDescriptor ReportRequest
        internalMetrics__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "internal_metrics"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor InternalMetrics)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'internalMetrics")) ::
              Data.ProtoLens.FieldDescriptor ReportRequest
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, reporter__field_descriptor),
           (Data.ProtoLens.Tag 2, auth__field_descriptor),
           (Data.ProtoLens.Tag 3, spans__field_descriptor),
           (Data.ProtoLens.Tag 5, timestampOffsetMicros__field_descriptor),
           (Data.ProtoLens.Tag 6, internalMetrics__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ReportRequest'_unknownFields
        (\ x__ y__ -> x__ {_ReportRequest'_unknownFields = y__})
  defMessage
    = ReportRequest'_constructor
        {_ReportRequest'reporter = Prelude.Nothing,
         _ReportRequest'auth = Prelude.Nothing,
         _ReportRequest'spans = Data.Vector.Generic.empty,
         _ReportRequest'timestampOffsetMicros = Data.ProtoLens.fieldDefault,
         _ReportRequest'internalMetrics = Prelude.Nothing,
         _ReportRequest'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ReportRequest
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Span
             -> Data.ProtoLens.Encoding.Bytes.Parser ReportRequest
        loop x mutable'spans
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'spans <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                        (Data.ProtoLens.Encoding.Growing.unsafeFreeze mutable'spans)
                      (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t)
                           (Lens.Family2.set
                              (Data.ProtoLens.Field.field @"vec'spans") frozen'spans x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "reporter"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"reporter") y x)
                                  mutable'spans
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "auth"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"auth") y x)
                                  mutable'spans
                        26
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "spans"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'spans y)
                                loop x v
                        40
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (Prelude.fmap
                                          Prelude.fromIntegral
                                          Data.ProtoLens.Encoding.Bytes.getVarInt)
                                       "timestamp_offset_micros"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"timestampOffsetMicros") y x)
                                  mutable'spans
                        50
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "internal_metrics"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"internalMetrics") y x)
                                  mutable'spans
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'spans
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'spans <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                 Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'spans)
          "ReportRequest"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'reporter") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just _v)
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage _v))
             ((Data.Monoid.<>)
                (case
                     Lens.Family2.view (Data.ProtoLens.Field.field @"maybe'auth") _x
                 of
                   Prelude.Nothing -> Data.Monoid.mempty
                   (Prelude.Just _v)
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage _v))
                ((Data.Monoid.<>)
                   (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                      (\ _v
                         -> (Data.Monoid.<>)
                              (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                              ((Prelude..)
                                 (\ bs
                                    -> (Data.Monoid.<>)
                                         (Data.ProtoLens.Encoding.Bytes.putVarInt
                                            (Prelude.fromIntegral (Data.ByteString.length bs)))
                                         (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                 Data.ProtoLens.encodeMessage _v))
                      (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'spans") _x))
                   ((Data.Monoid.<>)
                      (let
                         _v
                           = Lens.Family2.view
                               (Data.ProtoLens.Field.field @"timestampOffsetMicros") _x
                       in
                         if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                             Data.Monoid.mempty
                         else
                             (Data.Monoid.<>)
                               (Data.ProtoLens.Encoding.Bytes.putVarInt 40)
                               ((Prelude..)
                                  Data.ProtoLens.Encoding.Bytes.putVarInt Prelude.fromIntegral _v))
                      ((Data.Monoid.<>)
                         (case
                              Lens.Family2.view
                                (Data.ProtoLens.Field.field @"maybe'internalMetrics") _x
                          of
                            Prelude.Nothing -> Data.Monoid.mempty
                            (Prelude.Just _v)
                              -> (Data.Monoid.<>)
                                   (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                                   ((Prelude..)
                                      (\ bs
                                         -> (Data.Monoid.<>)
                                              (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                 (Prelude.fromIntegral (Data.ByteString.length bs)))
                                              (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                      Data.ProtoLens.encodeMessage _v))
                         (Data.ProtoLens.Encoding.Wire.buildFieldSet
                            (Lens.Family2.view Data.ProtoLens.unknownFields _x))))))
instance Control.DeepSeq.NFData ReportRequest where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ReportRequest'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ReportRequest'reporter x__)
                (Control.DeepSeq.deepseq
                   (_ReportRequest'auth x__)
                   (Control.DeepSeq.deepseq
                      (_ReportRequest'spans x__)
                      (Control.DeepSeq.deepseq
                         (_ReportRequest'timestampOffsetMicros x__)
                         (Control.DeepSeq.deepseq
                            (_ReportRequest'internalMetrics x__) ())))))
{- | Fields :
     
         * 'Proto.Collector_Fields.commands' @:: Lens' ReportResponse [Command]@
         * 'Proto.Collector_Fields.vec'commands' @:: Lens' ReportResponse (Data.Vector.Vector Command)@
         * 'Proto.Collector_Fields.receiveTimestamp' @:: Lens' ReportResponse Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Collector_Fields.maybe'receiveTimestamp' @:: Lens' ReportResponse (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Collector_Fields.transmitTimestamp' @:: Lens' ReportResponse Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Collector_Fields.maybe'transmitTimestamp' @:: Lens' ReportResponse (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Collector_Fields.errors' @:: Lens' ReportResponse [Data.Text.Text]@
         * 'Proto.Collector_Fields.vec'errors' @:: Lens' ReportResponse (Data.Vector.Vector Data.Text.Text)@
         * 'Proto.Collector_Fields.warnings' @:: Lens' ReportResponse [Data.Text.Text]@
         * 'Proto.Collector_Fields.vec'warnings' @:: Lens' ReportResponse (Data.Vector.Vector Data.Text.Text)@
         * 'Proto.Collector_Fields.infos' @:: Lens' ReportResponse [Data.Text.Text]@
         * 'Proto.Collector_Fields.vec'infos' @:: Lens' ReportResponse (Data.Vector.Vector Data.Text.Text)@ -}
data ReportResponse
  = ReportResponse'_constructor {_ReportResponse'commands :: !(Data.Vector.Vector Command),
                                 _ReportResponse'receiveTimestamp :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                 _ReportResponse'transmitTimestamp :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                                 _ReportResponse'errors :: !(Data.Vector.Vector Data.Text.Text),
                                 _ReportResponse'warnings :: !(Data.Vector.Vector Data.Text.Text),
                                 _ReportResponse'infos :: !(Data.Vector.Vector Data.Text.Text),
                                 _ReportResponse'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show ReportResponse where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField ReportResponse "commands" [Command] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReportResponse'commands
           (\ x__ y__ -> x__ {_ReportResponse'commands = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField ReportResponse "vec'commands" (Data.Vector.Vector Command) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReportResponse'commands
           (\ x__ y__ -> x__ {_ReportResponse'commands = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ReportResponse "receiveTimestamp" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReportResponse'receiveTimestamp
           (\ x__ y__ -> x__ {_ReportResponse'receiveTimestamp = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ReportResponse "maybe'receiveTimestamp" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReportResponse'receiveTimestamp
           (\ x__ y__ -> x__ {_ReportResponse'receiveTimestamp = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ReportResponse "transmitTimestamp" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReportResponse'transmitTimestamp
           (\ x__ y__ -> x__ {_ReportResponse'transmitTimestamp = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField ReportResponse "maybe'transmitTimestamp" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReportResponse'transmitTimestamp
           (\ x__ y__ -> x__ {_ReportResponse'transmitTimestamp = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ReportResponse "errors" [Data.Text.Text] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReportResponse'errors
           (\ x__ y__ -> x__ {_ReportResponse'errors = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField ReportResponse "vec'errors" (Data.Vector.Vector Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReportResponse'errors
           (\ x__ y__ -> x__ {_ReportResponse'errors = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ReportResponse "warnings" [Data.Text.Text] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReportResponse'warnings
           (\ x__ y__ -> x__ {_ReportResponse'warnings = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField ReportResponse "vec'warnings" (Data.Vector.Vector Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReportResponse'warnings
           (\ x__ y__ -> x__ {_ReportResponse'warnings = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField ReportResponse "infos" [Data.Text.Text] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReportResponse'infos
           (\ x__ y__ -> x__ {_ReportResponse'infos = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField ReportResponse "vec'infos" (Data.Vector.Vector Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _ReportResponse'infos
           (\ x__ y__ -> x__ {_ReportResponse'infos = y__}))
        Prelude.id
instance Data.ProtoLens.Message ReportResponse where
  messageName _ = Data.Text.pack "lightstep.collector.ReportResponse"
  packedMessageDescriptor _
    = "\n\
      \\SOReportResponse\DC28\n\
      \\bcommands\CAN\SOH \ETX(\v2\FS.lightstep.collector.CommandR\bcommands\DC2G\n\
      \\DC1receive_timestamp\CAN\STX \SOH(\v2\SUB.google.protobuf.TimestampR\DLEreceiveTimestamp\DC2I\n\
      \\DC2transmit_timestamp\CAN\ETX \SOH(\v2\SUB.google.protobuf.TimestampR\DC1transmitTimestamp\DC2\SYN\n\
      \\ACKerrors\CAN\EOT \ETX(\tR\ACKerrors\DC2\SUB\n\
      \\bwarnings\CAN\ENQ \ETX(\tR\bwarnings\DC2\DC4\n\
      \\ENQinfos\CAN\ACK \ETX(\tR\ENQinfos"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        commands__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "commands"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Command)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked
                 (Data.ProtoLens.Field.field @"commands")) ::
              Data.ProtoLens.FieldDescriptor ReportResponse
        receiveTimestamp__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "receive_timestamp"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'receiveTimestamp")) ::
              Data.ProtoLens.FieldDescriptor ReportResponse
        transmitTimestamp__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "transmit_timestamp"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'transmitTimestamp")) ::
              Data.ProtoLens.FieldDescriptor ReportResponse
        errors__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "errors"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"errors")) ::
              Data.ProtoLens.FieldDescriptor ReportResponse
        warnings__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "warnings"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked
                 (Data.ProtoLens.Field.field @"warnings")) ::
              Data.ProtoLens.FieldDescriptor ReportResponse
        infos__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "infos"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"infos")) ::
              Data.ProtoLens.FieldDescriptor ReportResponse
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, commands__field_descriptor),
           (Data.ProtoLens.Tag 2, receiveTimestamp__field_descriptor),
           (Data.ProtoLens.Tag 3, transmitTimestamp__field_descriptor),
           (Data.ProtoLens.Tag 4, errors__field_descriptor),
           (Data.ProtoLens.Tag 5, warnings__field_descriptor),
           (Data.ProtoLens.Tag 6, infos__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _ReportResponse'_unknownFields
        (\ x__ y__ -> x__ {_ReportResponse'_unknownFields = y__})
  defMessage
    = ReportResponse'_constructor
        {_ReportResponse'commands = Data.Vector.Generic.empty,
         _ReportResponse'receiveTimestamp = Prelude.Nothing,
         _ReportResponse'transmitTimestamp = Prelude.Nothing,
         _ReportResponse'errors = Data.Vector.Generic.empty,
         _ReportResponse'warnings = Data.Vector.Generic.empty,
         _ReportResponse'infos = Data.Vector.Generic.empty,
         _ReportResponse'_unknownFields = []}
  parseMessage
    = let
        loop ::
          ReportResponse
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Command
             -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Data.Text.Text
                -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Data.Text.Text
                   -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Data.Text.Text
                      -> Data.ProtoLens.Encoding.Bytes.Parser ReportResponse
        loop
          x
          mutable'commands
          mutable'errors
          mutable'infos
          mutable'warnings
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'commands <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                           (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                              mutable'commands)
                      frozen'errors <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                         (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                            mutable'errors)
                      frozen'infos <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                        (Data.ProtoLens.Encoding.Growing.unsafeFreeze mutable'infos)
                      frozen'warnings <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                           (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                              mutable'warnings)
                      (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t)
                           (Lens.Family2.set
                              (Data.ProtoLens.Field.field @"vec'commands") frozen'commands
                              (Lens.Family2.set
                                 (Data.ProtoLens.Field.field @"vec'errors") frozen'errors
                                 (Lens.Family2.set
                                    (Data.ProtoLens.Field.field @"vec'infos") frozen'infos
                                    (Lens.Family2.set
                                       (Data.ProtoLens.Field.field @"vec'warnings") frozen'warnings
                                       x)))))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "commands"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'commands y)
                                loop x v mutable'errors mutable'infos mutable'warnings
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "receive_timestamp"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"receiveTimestamp") y x)
                                  mutable'commands mutable'errors mutable'infos mutable'warnings
                        26
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "transmit_timestamp"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"transmitTimestamp") y x)
                                  mutable'commands mutable'errors mutable'infos mutable'warnings
                        34
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                        Data.ProtoLens.Encoding.Bytes.getBytes
                                                          (Prelude.fromIntegral len)
                                            Data.ProtoLens.Encoding.Bytes.runEither
                                              (case Data.Text.Encoding.decodeUtf8' value of
                                                 (Prelude.Left err)
                                                   -> Prelude.Left (Prelude.show err)
                                                 (Prelude.Right r) -> Prelude.Right r))
                                        "errors"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'errors y)
                                loop x mutable'commands v mutable'infos mutable'warnings
                        42
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                        Data.ProtoLens.Encoding.Bytes.getBytes
                                                          (Prelude.fromIntegral len)
                                            Data.ProtoLens.Encoding.Bytes.runEither
                                              (case Data.Text.Encoding.decodeUtf8' value of
                                                 (Prelude.Left err)
                                                   -> Prelude.Left (Prelude.show err)
                                                 (Prelude.Right r) -> Prelude.Right r))
                                        "warnings"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'warnings y)
                                loop x mutable'commands mutable'errors mutable'infos v
                        50
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                        Data.ProtoLens.Encoding.Bytes.getBytes
                                                          (Prelude.fromIntegral len)
                                            Data.ProtoLens.Encoding.Bytes.runEither
                                              (case Data.Text.Encoding.decodeUtf8' value of
                                                 (Prelude.Left err)
                                                   -> Prelude.Left (Prelude.show err)
                                                 (Prelude.Right r) -> Prelude.Right r))
                                        "infos"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'infos y)
                                loop x mutable'commands mutable'errors v mutable'warnings
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'commands mutable'errors mutable'infos mutable'warnings
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'commands <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                    Data.ProtoLens.Encoding.Growing.new
              mutable'errors <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                  Data.ProtoLens.Encoding.Growing.new
              mutable'infos <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                 Data.ProtoLens.Encoding.Growing.new
              mutable'warnings <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                    Data.ProtoLens.Encoding.Growing.new
              loop
                Data.ProtoLens.defMessage mutable'commands mutable'errors
                mutable'infos mutable'warnings)
          "ReportResponse"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                (\ _v
                   -> (Data.Monoid.<>)
                        (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                        ((Prelude..)
                           (\ bs
                              -> (Data.Monoid.<>)
                                   (Data.ProtoLens.Encoding.Bytes.putVarInt
                                      (Prelude.fromIntegral (Data.ByteString.length bs)))
                                   (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                           Data.ProtoLens.encodeMessage _v))
                (Lens.Family2.view
                   (Data.ProtoLens.Field.field @"vec'commands") _x))
             ((Data.Monoid.<>)
                (case
                     Lens.Family2.view
                       (Data.ProtoLens.Field.field @"maybe'receiveTimestamp") _x
                 of
                   Prelude.Nothing -> Data.Monoid.mempty
                   (Prelude.Just _v)
                     -> (Data.Monoid.<>)
                          (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                          ((Prelude..)
                             (\ bs
                                -> (Data.Monoid.<>)
                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                        (Prelude.fromIntegral (Data.ByteString.length bs)))
                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                             Data.ProtoLens.encodeMessage _v))
                ((Data.Monoid.<>)
                   (case
                        Lens.Family2.view
                          (Data.ProtoLens.Field.field @"maybe'transmitTimestamp") _x
                    of
                      Prelude.Nothing -> Data.Monoid.mempty
                      (Prelude.Just _v)
                        -> (Data.Monoid.<>)
                             (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                             ((Prelude..)
                                (\ bs
                                   -> (Data.Monoid.<>)
                                        (Data.ProtoLens.Encoding.Bytes.putVarInt
                                           (Prelude.fromIntegral (Data.ByteString.length bs)))
                                        (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                Data.ProtoLens.encodeMessage _v))
                   ((Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                         (\ _v
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                                 ((Prelude..)
                                    (\ bs
                                       -> (Data.Monoid.<>)
                                            (Data.ProtoLens.Encoding.Bytes.putVarInt
                                               (Prelude.fromIntegral (Data.ByteString.length bs)))
                                            (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                    Data.Text.Encoding.encodeUtf8 _v))
                         (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'errors") _x))
                      ((Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                            (\ _v
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt 42)
                                    ((Prelude..)
                                       (\ bs
                                          -> (Data.Monoid.<>)
                                               (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                  (Prelude.fromIntegral
                                                     (Data.ByteString.length bs)))
                                               (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                       Data.Text.Encoding.encodeUtf8 _v))
                            (Lens.Family2.view
                               (Data.ProtoLens.Field.field @"vec'warnings") _x))
                         ((Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                               (\ _v
                                  -> (Data.Monoid.<>)
                                       (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                                       ((Prelude..)
                                          (\ bs
                                             -> (Data.Monoid.<>)
                                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                     (Prelude.fromIntegral
                                                        (Data.ByteString.length bs)))
                                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                          Data.Text.Encoding.encodeUtf8 _v))
                               (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'infos") _x))
                            (Data.ProtoLens.Encoding.Wire.buildFieldSet
                               (Lens.Family2.view Data.ProtoLens.unknownFields _x)))))))
instance Control.DeepSeq.NFData ReportResponse where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_ReportResponse'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_ReportResponse'commands x__)
                (Control.DeepSeq.deepseq
                   (_ReportResponse'receiveTimestamp x__)
                   (Control.DeepSeq.deepseq
                      (_ReportResponse'transmitTimestamp x__)
                      (Control.DeepSeq.deepseq
                         (_ReportResponse'errors x__)
                         (Control.DeepSeq.deepseq
                            (_ReportResponse'warnings x__)
                            (Control.DeepSeq.deepseq (_ReportResponse'infos x__) ()))))))
{- | Fields :
     
         * 'Proto.Collector_Fields.reporterId' @:: Lens' Reporter Data.Word.Word64@
         * 'Proto.Collector_Fields.tags' @:: Lens' Reporter [KeyValue]@
         * 'Proto.Collector_Fields.vec'tags' @:: Lens' Reporter (Data.Vector.Vector KeyValue)@ -}
data Reporter
  = Reporter'_constructor {_Reporter'reporterId :: !Data.Word.Word64,
                           _Reporter'tags :: !(Data.Vector.Vector KeyValue),
                           _Reporter'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Reporter where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Reporter "reporterId" Data.Word.Word64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Reporter'reporterId
           (\ x__ y__ -> x__ {_Reporter'reporterId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Reporter "tags" [KeyValue] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Reporter'tags (\ x__ y__ -> x__ {_Reporter'tags = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField Reporter "vec'tags" (Data.Vector.Vector KeyValue) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Reporter'tags (\ x__ y__ -> x__ {_Reporter'tags = y__}))
        Prelude.id
instance Data.ProtoLens.Message Reporter where
  messageName _ = Data.Text.pack "lightstep.collector.Reporter"
  packedMessageDescriptor _
    = "\n\
      \\bReporter\DC2#\n\
      \\vreporter_id\CAN\SOH \SOH(\EOTR\n\
      \reporterIdB\STX0\SOH\DC21\n\
      \\EOTtags\CAN\EOT \ETX(\v2\GS.lightstep.collector.KeyValueR\EOTtags"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        reporterId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "reporter_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.UInt64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Word.Word64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"reporterId")) ::
              Data.ProtoLens.FieldDescriptor Reporter
        tags__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "tags"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor KeyValue)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"tags")) ::
              Data.ProtoLens.FieldDescriptor Reporter
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, reporterId__field_descriptor),
           (Data.ProtoLens.Tag 4, tags__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Reporter'_unknownFields
        (\ x__ y__ -> x__ {_Reporter'_unknownFields = y__})
  defMessage
    = Reporter'_constructor
        {_Reporter'reporterId = Data.ProtoLens.fieldDefault,
         _Reporter'tags = Data.Vector.Generic.empty,
         _Reporter'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Reporter
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld KeyValue
             -> Data.ProtoLens.Encoding.Bytes.Parser Reporter
        loop x mutable'tags
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'tags <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.unsafeFreeze mutable'tags)
                      (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t)
                           (Lens.Family2.set
                              (Data.ProtoLens.Field.field @"vec'tags") frozen'tags x))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        8 -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       Data.ProtoLens.Encoding.Bytes.getVarInt "reporter_id"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"reporterId") y x)
                                  mutable'tags
                        34
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "tags"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'tags y)
                                loop x v
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'tags
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'tags <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                Data.ProtoLens.Encoding.Growing.new
              loop Data.ProtoLens.defMessage mutable'tags)
          "Reporter"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v
                  = Lens.Family2.view (Data.ProtoLens.Field.field @"reporterId") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt _v))
             ((Data.Monoid.<>)
                (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                   (\ _v
                      -> (Data.Monoid.<>)
                           (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                           ((Prelude..)
                              (\ bs
                                 -> (Data.Monoid.<>)
                                      (Data.ProtoLens.Encoding.Bytes.putVarInt
                                         (Prelude.fromIntegral (Data.ByteString.length bs)))
                                      (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                              Data.ProtoLens.encodeMessage _v))
                   (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'tags") _x))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData Reporter where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Reporter'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Reporter'reporterId x__)
                (Control.DeepSeq.deepseq (_Reporter'tags x__) ()))
{- | Fields :
     
         * 'Proto.Collector_Fields.spanContext' @:: Lens' Span SpanContext@
         * 'Proto.Collector_Fields.maybe'spanContext' @:: Lens' Span (Prelude.Maybe SpanContext)@
         * 'Proto.Collector_Fields.operationName' @:: Lens' Span Data.Text.Text@
         * 'Proto.Collector_Fields.references' @:: Lens' Span [Reference]@
         * 'Proto.Collector_Fields.vec'references' @:: Lens' Span (Data.Vector.Vector Reference)@
         * 'Proto.Collector_Fields.startTimestamp' @:: Lens' Span Proto.Google.Protobuf.Timestamp.Timestamp@
         * 'Proto.Collector_Fields.maybe'startTimestamp' @:: Lens' Span (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp)@
         * 'Proto.Collector_Fields.durationMicros' @:: Lens' Span Data.Word.Word64@
         * 'Proto.Collector_Fields.tags' @:: Lens' Span [KeyValue]@
         * 'Proto.Collector_Fields.vec'tags' @:: Lens' Span (Data.Vector.Vector KeyValue)@
         * 'Proto.Collector_Fields.logs' @:: Lens' Span [Log]@
         * 'Proto.Collector_Fields.vec'logs' @:: Lens' Span (Data.Vector.Vector Log)@ -}
data Span
  = Span'_constructor {_Span'spanContext :: !(Prelude.Maybe SpanContext),
                       _Span'operationName :: !Data.Text.Text,
                       _Span'references :: !(Data.Vector.Vector Reference),
                       _Span'startTimestamp :: !(Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp),
                       _Span'durationMicros :: !Data.Word.Word64,
                       _Span'tags :: !(Data.Vector.Vector KeyValue),
                       _Span'logs :: !(Data.Vector.Vector Log),
                       _Span'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show Span where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField Span "spanContext" SpanContext where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Span'spanContext (\ x__ y__ -> x__ {_Span'spanContext = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Span "maybe'spanContext" (Prelude.Maybe SpanContext) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Span'spanContext (\ x__ y__ -> x__ {_Span'spanContext = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Span "operationName" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Span'operationName (\ x__ y__ -> x__ {_Span'operationName = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Span "references" [Reference] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Span'references (\ x__ y__ -> x__ {_Span'references = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField Span "vec'references" (Data.Vector.Vector Reference) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Span'references (\ x__ y__ -> x__ {_Span'references = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Span "startTimestamp" Proto.Google.Protobuf.Timestamp.Timestamp where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Span'startTimestamp
           (\ x__ y__ -> x__ {_Span'startTimestamp = y__}))
        (Data.ProtoLens.maybeLens Data.ProtoLens.defMessage)
instance Data.ProtoLens.Field.HasField Span "maybe'startTimestamp" (Prelude.Maybe Proto.Google.Protobuf.Timestamp.Timestamp) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Span'startTimestamp
           (\ x__ y__ -> x__ {_Span'startTimestamp = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Span "durationMicros" Data.Word.Word64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Span'durationMicros
           (\ x__ y__ -> x__ {_Span'durationMicros = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Span "tags" [KeyValue] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Span'tags (\ x__ y__ -> x__ {_Span'tags = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField Span "vec'tags" (Data.Vector.Vector KeyValue) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Span'tags (\ x__ y__ -> x__ {_Span'tags = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField Span "logs" [Log] where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Span'logs (\ x__ y__ -> x__ {_Span'logs = y__}))
        (Lens.Family2.Unchecked.lens
           Data.Vector.Generic.toList
           (\ _ y__ -> Data.Vector.Generic.fromList y__))
instance Data.ProtoLens.Field.HasField Span "vec'logs" (Data.Vector.Vector Log) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _Span'logs (\ x__ y__ -> x__ {_Span'logs = y__}))
        Prelude.id
instance Data.ProtoLens.Message Span where
  messageName _ = Data.Text.pack "lightstep.collector.Span"
  packedMessageDescriptor _
    = "\n\
      \\EOTSpan\DC2C\n\
      \\fspan_context\CAN\SOH \SOH(\v2 .lightstep.collector.SpanContextR\vspanContext\DC2%\n\
      \\SOoperation_name\CAN\STX \SOH(\tR\roperationName\DC2>\n\
      \\n\
      \references\CAN\ETX \ETX(\v2\RS.lightstep.collector.ReferenceR\n\
      \references\DC2C\n\
      \\SIstart_timestamp\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\SOstartTimestamp\DC2+\n\
      \\SIduration_micros\CAN\ENQ \SOH(\EOTR\SOdurationMicrosB\STX0\SOH\DC21\n\
      \\EOTtags\CAN\ACK \ETX(\v2\GS.lightstep.collector.KeyValueR\EOTtags\DC2,\n\
      \\EOTlogs\CAN\a \ETX(\v2\CAN.lightstep.collector.LogR\EOTlogs"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        spanContext__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "span_context"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor SpanContext)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'spanContext")) ::
              Data.ProtoLens.FieldDescriptor Span
        operationName__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "operation_name"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"operationName")) ::
              Data.ProtoLens.FieldDescriptor Span
        references__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "references"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Reference)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked
                 (Data.ProtoLens.Field.field @"references")) ::
              Data.ProtoLens.FieldDescriptor Span
        startTimestamp__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "start_timestamp"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Proto.Google.Protobuf.Timestamp.Timestamp)
              (Data.ProtoLens.OptionalField
                 (Data.ProtoLens.Field.field @"maybe'startTimestamp")) ::
              Data.ProtoLens.FieldDescriptor Span
        durationMicros__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "duration_micros"
              (Data.ProtoLens.ScalarField Data.ProtoLens.UInt64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Word.Word64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional
                 (Data.ProtoLens.Field.field @"durationMicros")) ::
              Data.ProtoLens.FieldDescriptor Span
        tags__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "tags"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor KeyValue)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"tags")) ::
              Data.ProtoLens.FieldDescriptor Span
        logs__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "logs"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor Log)
              (Data.ProtoLens.RepeatedField
                 Data.ProtoLens.Unpacked (Data.ProtoLens.Field.field @"logs")) ::
              Data.ProtoLens.FieldDescriptor Span
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, spanContext__field_descriptor),
           (Data.ProtoLens.Tag 2, operationName__field_descriptor),
           (Data.ProtoLens.Tag 3, references__field_descriptor),
           (Data.ProtoLens.Tag 4, startTimestamp__field_descriptor),
           (Data.ProtoLens.Tag 5, durationMicros__field_descriptor),
           (Data.ProtoLens.Tag 6, tags__field_descriptor),
           (Data.ProtoLens.Tag 7, logs__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _Span'_unknownFields
        (\ x__ y__ -> x__ {_Span'_unknownFields = y__})
  defMessage
    = Span'_constructor
        {_Span'spanContext = Prelude.Nothing,
         _Span'operationName = Data.ProtoLens.fieldDefault,
         _Span'references = Data.Vector.Generic.empty,
         _Span'startTimestamp = Prelude.Nothing,
         _Span'durationMicros = Data.ProtoLens.fieldDefault,
         _Span'tags = Data.Vector.Generic.empty,
         _Span'logs = Data.Vector.Generic.empty, _Span'_unknownFields = []}
  parseMessage
    = let
        loop ::
          Span
          -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Log
             -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld Reference
                -> Data.ProtoLens.Encoding.Growing.Growing Data.Vector.Vector Data.ProtoLens.Encoding.Growing.RealWorld KeyValue
                   -> Data.ProtoLens.Encoding.Bytes.Parser Span
        loop x mutable'logs mutable'references mutable'tags
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do frozen'logs <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.unsafeFreeze mutable'logs)
                      frozen'references <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                             (Data.ProtoLens.Encoding.Growing.unsafeFreeze
                                                mutable'references)
                      frozen'tags <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.unsafeFreeze mutable'tags)
                      (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t)
                           (Lens.Family2.set
                              (Data.ProtoLens.Field.field @"vec'logs") frozen'logs
                              (Lens.Family2.set
                                 (Data.ProtoLens.Field.field @"vec'references") frozen'references
                                 (Lens.Family2.set
                                    (Data.ProtoLens.Field.field @"vec'tags") frozen'tags x))))
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "span_context"
                                loop
                                  (Lens.Family2.set (Data.ProtoLens.Field.field @"spanContext") y x)
                                  mutable'logs mutable'references mutable'tags
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "operation_name"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"operationName") y x)
                                  mutable'logs mutable'references mutable'tags
                        26
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "references"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'references y)
                                loop x mutable'logs v mutable'tags
                        34
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                           Data.ProtoLens.Encoding.Bytes.isolate
                                             (Prelude.fromIntegral len) Data.ProtoLens.parseMessage)
                                       "start_timestamp"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"startTimestamp") y x)
                                  mutable'logs mutable'references mutable'tags
                        40
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       Data.ProtoLens.Encoding.Bytes.getVarInt "duration_micros"
                                loop
                                  (Lens.Family2.set
                                     (Data.ProtoLens.Field.field @"durationMicros") y x)
                                  mutable'logs mutable'references mutable'tags
                        50
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "tags"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'tags y)
                                loop x mutable'logs mutable'references v
                        58
                          -> do !y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                        (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                            Data.ProtoLens.Encoding.Bytes.isolate
                                              (Prelude.fromIntegral len)
                                              Data.ProtoLens.parseMessage)
                                        "logs"
                                v <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                       (Data.ProtoLens.Encoding.Growing.append mutable'logs y)
                                loop x v mutable'references mutable'tags
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
                                  mutable'logs mutable'references mutable'tags
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do mutable'logs <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                Data.ProtoLens.Encoding.Growing.new
              mutable'references <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                      Data.ProtoLens.Encoding.Growing.new
              mutable'tags <- Data.ProtoLens.Encoding.Parser.Unsafe.unsafeLiftIO
                                Data.ProtoLens.Encoding.Growing.new
              loop
                Data.ProtoLens.defMessage mutable'logs mutable'references
                mutable'tags)
          "Span"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (case
                  Lens.Family2.view
                    (Data.ProtoLens.Field.field @"maybe'spanContext") _x
              of
                Prelude.Nothing -> Data.Monoid.mempty
                (Prelude.Just _v)
                  -> (Data.Monoid.<>)
                       (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                       ((Prelude..)
                          (\ bs
                             -> (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                     (Prelude.fromIntegral (Data.ByteString.length bs)))
                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                          Data.ProtoLens.encodeMessage _v))
             ((Data.Monoid.<>)
                (let
                   _v
                     = Lens.Family2.view
                         (Data.ProtoLens.Field.field @"operationName") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                ((Data.Monoid.<>)
                   (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                      (\ _v
                         -> (Data.Monoid.<>)
                              (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                              ((Prelude..)
                                 (\ bs
                                    -> (Data.Monoid.<>)
                                         (Data.ProtoLens.Encoding.Bytes.putVarInt
                                            (Prelude.fromIntegral (Data.ByteString.length bs)))
                                         (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                 Data.ProtoLens.encodeMessage _v))
                      (Lens.Family2.view
                         (Data.ProtoLens.Field.field @"vec'references") _x))
                   ((Data.Monoid.<>)
                      (case
                           Lens.Family2.view
                             (Data.ProtoLens.Field.field @"maybe'startTimestamp") _x
                       of
                         Prelude.Nothing -> Data.Monoid.mempty
                         (Prelude.Just _v)
                           -> (Data.Monoid.<>)
                                (Data.ProtoLens.Encoding.Bytes.putVarInt 34)
                                ((Prelude..)
                                   (\ bs
                                      -> (Data.Monoid.<>)
                                           (Data.ProtoLens.Encoding.Bytes.putVarInt
                                              (Prelude.fromIntegral (Data.ByteString.length bs)))
                                           (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                   Data.ProtoLens.encodeMessage _v))
                      ((Data.Monoid.<>)
                         (let
                            _v
                              = Lens.Family2.view
                                  (Data.ProtoLens.Field.field @"durationMicros") _x
                          in
                            if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                                Data.Monoid.mempty
                            else
                                (Data.Monoid.<>)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt 40)
                                  (Data.ProtoLens.Encoding.Bytes.putVarInt _v))
                         ((Data.Monoid.<>)
                            (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                               (\ _v
                                  -> (Data.Monoid.<>)
                                       (Data.ProtoLens.Encoding.Bytes.putVarInt 50)
                                       ((Prelude..)
                                          (\ bs
                                             -> (Data.Monoid.<>)
                                                  (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                     (Prelude.fromIntegral
                                                        (Data.ByteString.length bs)))
                                                  (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                          Data.ProtoLens.encodeMessage _v))
                               (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'tags") _x))
                            ((Data.Monoid.<>)
                               (Data.ProtoLens.Encoding.Bytes.foldMapBuilder
                                  (\ _v
                                     -> (Data.Monoid.<>)
                                          (Data.ProtoLens.Encoding.Bytes.putVarInt 58)
                                          ((Prelude..)
                                             (\ bs
                                                -> (Data.Monoid.<>)
                                                     (Data.ProtoLens.Encoding.Bytes.putVarInt
                                                        (Prelude.fromIntegral
                                                           (Data.ByteString.length bs)))
                                                     (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                             Data.ProtoLens.encodeMessage _v))
                                  (Lens.Family2.view (Data.ProtoLens.Field.field @"vec'logs") _x))
                               (Data.ProtoLens.Encoding.Wire.buildFieldSet
                                  (Lens.Family2.view Data.ProtoLens.unknownFields _x))))))))
instance Control.DeepSeq.NFData Span where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_Span'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_Span'spanContext x__)
                (Control.DeepSeq.deepseq
                   (_Span'operationName x__)
                   (Control.DeepSeq.deepseq
                      (_Span'references x__)
                      (Control.DeepSeq.deepseq
                         (_Span'startTimestamp x__)
                         (Control.DeepSeq.deepseq
                            (_Span'durationMicros x__)
                            (Control.DeepSeq.deepseq
                               (_Span'tags x__)
                               (Control.DeepSeq.deepseq (_Span'logs x__) ())))))))
{- | Fields :
     
         * 'Proto.Collector_Fields.traceId' @:: Lens' SpanContext Data.Word.Word64@
         * 'Proto.Collector_Fields.spanId' @:: Lens' SpanContext Data.Word.Word64@
         * 'Proto.Collector_Fields.baggage' @:: Lens' SpanContext (Data.Map.Map Data.Text.Text Data.Text.Text)@ -}
data SpanContext
  = SpanContext'_constructor {_SpanContext'traceId :: !Data.Word.Word64,
                              _SpanContext'spanId :: !Data.Word.Word64,
                              _SpanContext'baggage :: !(Data.Map.Map Data.Text.Text Data.Text.Text),
                              _SpanContext'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show SpanContext where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField SpanContext "traceId" Data.Word.Word64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SpanContext'traceId
           (\ x__ y__ -> x__ {_SpanContext'traceId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField SpanContext "spanId" Data.Word.Word64 where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SpanContext'spanId (\ x__ y__ -> x__ {_SpanContext'spanId = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField SpanContext "baggage" (Data.Map.Map Data.Text.Text Data.Text.Text) where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SpanContext'baggage
           (\ x__ y__ -> x__ {_SpanContext'baggage = y__}))
        Prelude.id
instance Data.ProtoLens.Message SpanContext where
  messageName _ = Data.Text.pack "lightstep.collector.SpanContext"
  packedMessageDescriptor _
    = "\n\
      \\vSpanContext\DC2\GS\n\
      \\btrace_id\CAN\SOH \SOH(\EOTR\atraceIdB\STX0\SOH\DC2\ESC\n\
      \\aspan_id\CAN\STX \SOH(\EOTR\ACKspanIdB\STX0\SOH\DC2G\n\
      \\abaggage\CAN\ETX \ETX(\v2-.lightstep.collector.SpanContext.BaggageEntryR\abaggage\SUB:\n\
      \\fBaggageEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
      \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        traceId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "trace_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.UInt64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Word.Word64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"traceId")) ::
              Data.ProtoLens.FieldDescriptor SpanContext
        spanId__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "span_id"
              (Data.ProtoLens.ScalarField Data.ProtoLens.UInt64Field ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Word.Word64)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"spanId")) ::
              Data.ProtoLens.FieldDescriptor SpanContext
        baggage__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "baggage"
              (Data.ProtoLens.MessageField Data.ProtoLens.MessageType ::
                 Data.ProtoLens.FieldTypeDescriptor SpanContext'BaggageEntry)
              (Data.ProtoLens.MapField
                 (Data.ProtoLens.Field.field @"key")
                 (Data.ProtoLens.Field.field @"value")
                 (Data.ProtoLens.Field.field @"baggage")) ::
              Data.ProtoLens.FieldDescriptor SpanContext
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, traceId__field_descriptor),
           (Data.ProtoLens.Tag 2, spanId__field_descriptor),
           (Data.ProtoLens.Tag 3, baggage__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _SpanContext'_unknownFields
        (\ x__ y__ -> x__ {_SpanContext'_unknownFields = y__})
  defMessage
    = SpanContext'_constructor
        {_SpanContext'traceId = Data.ProtoLens.fieldDefault,
         _SpanContext'spanId = Data.ProtoLens.fieldDefault,
         _SpanContext'baggage = Data.Map.empty,
         _SpanContext'_unknownFields = []}
  parseMessage
    = let
        loop ::
          SpanContext -> Data.ProtoLens.Encoding.Bytes.Parser SpanContext
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        8 -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       Data.ProtoLens.Encoding.Bytes.getVarInt "trace_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"traceId") y x)
                        16
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       Data.ProtoLens.Encoding.Bytes.getVarInt "span_id"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"spanId") y x)
                        26
                          -> do !(entry :: SpanContext'BaggageEntry) <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                                                          (do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                                              Data.ProtoLens.Encoding.Bytes.isolate
                                                                                (Prelude.fromIntegral
                                                                                   len)
                                                                                Data.ProtoLens.parseMessage)
                                                                          "baggage"
                                (let
                                   key = Lens.Family2.view (Data.ProtoLens.Field.field @"key") entry
                                   value
                                     = Lens.Family2.view (Data.ProtoLens.Field.field @"value") entry
                                 in
                                   loop
                                     (Lens.Family2.over
                                        (Data.ProtoLens.Field.field @"baggage")
                                        (\ !t -> Data.Map.insert key value t) x))
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "SpanContext"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let
                _v = Lens.Family2.view (Data.ProtoLens.Field.field @"traceId") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 8)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt _v))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"spanId") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 16)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt _v))
                ((Data.Monoid.<>)
                   (Data.Monoid.mconcat
                      (Prelude.map
                         (\ _v
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt 26)
                                 ((Prelude..)
                                    (\ bs
                                       -> (Data.Monoid.<>)
                                            (Data.ProtoLens.Encoding.Bytes.putVarInt
                                               (Prelude.fromIntegral (Data.ByteString.length bs)))
                                            (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                                    Data.ProtoLens.encodeMessage
                                    (Lens.Family2.set
                                       (Data.ProtoLens.Field.field @"key") (Prelude.fst _v)
                                       (Lens.Family2.set
                                          (Data.ProtoLens.Field.field @"value") (Prelude.snd _v)
                                          (Data.ProtoLens.defMessage ::
                                             SpanContext'BaggageEntry)))))
                         (Data.Map.toList
                            (Lens.Family2.view (Data.ProtoLens.Field.field @"baggage") _x))))
                   (Data.ProtoLens.Encoding.Wire.buildFieldSet
                      (Lens.Family2.view Data.ProtoLens.unknownFields _x))))
instance Control.DeepSeq.NFData SpanContext where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_SpanContext'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_SpanContext'traceId x__)
                (Control.DeepSeq.deepseq
                   (_SpanContext'spanId x__)
                   (Control.DeepSeq.deepseq (_SpanContext'baggage x__) ())))
{- | Fields :
     
         * 'Proto.Collector_Fields.key' @:: Lens' SpanContext'BaggageEntry Data.Text.Text@
         * 'Proto.Collector_Fields.value' @:: Lens' SpanContext'BaggageEntry Data.Text.Text@ -}
data SpanContext'BaggageEntry
  = SpanContext'BaggageEntry'_constructor {_SpanContext'BaggageEntry'key :: !Data.Text.Text,
                                           _SpanContext'BaggageEntry'value :: !Data.Text.Text,
                                           _SpanContext'BaggageEntry'_unknownFields :: !Data.ProtoLens.FieldSet}
  deriving stock (Prelude.Eq, Prelude.Ord)
instance Prelude.Show SpanContext'BaggageEntry where
  showsPrec _ __x __s
    = Prelude.showChar
        '{'
        (Prelude.showString
           (Data.ProtoLens.showMessageShort __x) (Prelude.showChar '}' __s))
instance Data.ProtoLens.Field.HasField SpanContext'BaggageEntry "key" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SpanContext'BaggageEntry'key
           (\ x__ y__ -> x__ {_SpanContext'BaggageEntry'key = y__}))
        Prelude.id
instance Data.ProtoLens.Field.HasField SpanContext'BaggageEntry "value" Data.Text.Text where
  fieldOf _
    = (Prelude..)
        (Lens.Family2.Unchecked.lens
           _SpanContext'BaggageEntry'value
           (\ x__ y__ -> x__ {_SpanContext'BaggageEntry'value = y__}))
        Prelude.id
instance Data.ProtoLens.Message SpanContext'BaggageEntry where
  messageName _
    = Data.Text.pack "lightstep.collector.SpanContext.BaggageEntry"
  packedMessageDescriptor _
    = "\n\
      \\fBaggageEntry\DC2\DLE\n\
      \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
      \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH"
  packedFileDescriptor _ = packedFileDescriptor
  fieldsByTag
    = let
        key__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "key"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"key")) ::
              Data.ProtoLens.FieldDescriptor SpanContext'BaggageEntry
        value__field_descriptor
          = Data.ProtoLens.FieldDescriptor
              "value"
              (Data.ProtoLens.ScalarField Data.ProtoLens.StringField ::
                 Data.ProtoLens.FieldTypeDescriptor Data.Text.Text)
              (Data.ProtoLens.PlainField
                 Data.ProtoLens.Optional (Data.ProtoLens.Field.field @"value")) ::
              Data.ProtoLens.FieldDescriptor SpanContext'BaggageEntry
      in
        Data.Map.fromList
          [(Data.ProtoLens.Tag 1, key__field_descriptor),
           (Data.ProtoLens.Tag 2, value__field_descriptor)]
  unknownFields
    = Lens.Family2.Unchecked.lens
        _SpanContext'BaggageEntry'_unknownFields
        (\ x__ y__ -> x__ {_SpanContext'BaggageEntry'_unknownFields = y__})
  defMessage
    = SpanContext'BaggageEntry'_constructor
        {_SpanContext'BaggageEntry'key = Data.ProtoLens.fieldDefault,
         _SpanContext'BaggageEntry'value = Data.ProtoLens.fieldDefault,
         _SpanContext'BaggageEntry'_unknownFields = []}
  parseMessage
    = let
        loop ::
          SpanContext'BaggageEntry
          -> Data.ProtoLens.Encoding.Bytes.Parser SpanContext'BaggageEntry
        loop x
          = do end <- Data.ProtoLens.Encoding.Bytes.atEnd
               if end then
                   do (let missing = []
                       in
                         if Prelude.null missing then
                             Prelude.return ()
                         else
                             Prelude.fail
                               ((Prelude.++)
                                  "Missing required fields: "
                                  (Prelude.show (missing :: [Prelude.String]))))
                      Prelude.return
                        (Lens.Family2.over
                           Data.ProtoLens.unknownFields (\ !t -> Prelude.reverse t) x)
               else
                   do tag <- Data.ProtoLens.Encoding.Bytes.getVarInt
                      case tag of
                        10
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "key"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"key") y x)
                        18
                          -> do y <- (Data.ProtoLens.Encoding.Bytes.<?>)
                                       (do value <- do len <- Data.ProtoLens.Encoding.Bytes.getVarInt
                                                       Data.ProtoLens.Encoding.Bytes.getBytes
                                                         (Prelude.fromIntegral len)
                                           Data.ProtoLens.Encoding.Bytes.runEither
                                             (case Data.Text.Encoding.decodeUtf8' value of
                                                (Prelude.Left err)
                                                  -> Prelude.Left (Prelude.show err)
                                                (Prelude.Right r) -> Prelude.Right r))
                                       "value"
                                loop (Lens.Family2.set (Data.ProtoLens.Field.field @"value") y x)
                        wire
                          -> do !y <- Data.ProtoLens.Encoding.Wire.parseTaggedValueFromWire
                                        wire
                                loop
                                  (Lens.Family2.over
                                     Data.ProtoLens.unknownFields (\ !t -> (:) y t) x)
      in
        (Data.ProtoLens.Encoding.Bytes.<?>)
          (do loop Data.ProtoLens.defMessage) "BaggageEntry"
  buildMessage
    = \ _x
        -> (Data.Monoid.<>)
             (let _v = Lens.Family2.view (Data.ProtoLens.Field.field @"key") _x
              in
                if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                    Data.Monoid.mempty
                else
                    (Data.Monoid.<>)
                      (Data.ProtoLens.Encoding.Bytes.putVarInt 10)
                      ((Prelude..)
                         (\ bs
                            -> (Data.Monoid.<>)
                                 (Data.ProtoLens.Encoding.Bytes.putVarInt
                                    (Prelude.fromIntegral (Data.ByteString.length bs)))
                                 (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                         Data.Text.Encoding.encodeUtf8 _v))
             ((Data.Monoid.<>)
                (let
                   _v = Lens.Family2.view (Data.ProtoLens.Field.field @"value") _x
                 in
                   if (Prelude.==) _v Data.ProtoLens.fieldDefault then
                       Data.Monoid.mempty
                   else
                       (Data.Monoid.<>)
                         (Data.ProtoLens.Encoding.Bytes.putVarInt 18)
                         ((Prelude..)
                            (\ bs
                               -> (Data.Monoid.<>)
                                    (Data.ProtoLens.Encoding.Bytes.putVarInt
                                       (Prelude.fromIntegral (Data.ByteString.length bs)))
                                    (Data.ProtoLens.Encoding.Bytes.putBytes bs))
                            Data.Text.Encoding.encodeUtf8 _v))
                (Data.ProtoLens.Encoding.Wire.buildFieldSet
                   (Lens.Family2.view Data.ProtoLens.unknownFields _x)))
instance Control.DeepSeq.NFData SpanContext'BaggageEntry where
  rnf
    = \ x__
        -> Control.DeepSeq.deepseq
             (_SpanContext'BaggageEntry'_unknownFields x__)
             (Control.DeepSeq.deepseq
                (_SpanContext'BaggageEntry'key x__)
                (Control.DeepSeq.deepseq (_SpanContext'BaggageEntry'value x__) ()))
data CollectorService = CollectorService {}
instance Data.ProtoLens.Service.Types.Service CollectorService where
  type ServiceName CollectorService = "CollectorService"
  type ServicePackage CollectorService = "lightstep.collector"
  type ServiceMethods CollectorService = '["report"]
instance Data.ProtoLens.Service.Types.HasMethodImpl CollectorService "report" where
  type MethodName CollectorService "report" = "Report"
  type MethodInput CollectorService "report" = ReportRequest
  type MethodOutput CollectorService "report" = ReportResponse
  type MethodStreamingType CollectorService "report" = 'Data.ProtoLens.Service.Types.NonStreaming
packedFileDescriptor :: Data.ByteString.ByteString
packedFileDescriptor
  = "\n\
    \\SIcollector.proto\DC2\DC3lightstep.collector\SUB\USgoogle/protobuf/timestamp.proto\SUB\FSgoogle/api/annotations.proto\"\206\SOH\n\
    \\vSpanContext\DC2\GS\n\
    \\btrace_id\CAN\SOH \SOH(\EOTR\atraceIdB\STX0\SOH\DC2\ESC\n\
    \\aspan_id\CAN\STX \SOH(\EOTR\ACKspanIdB\STX0\SOH\DC2G\n\
    \\abaggage\CAN\ETX \ETX(\v2-.lightstep.collector.SpanContext.BaggageEntryR\abaggage\SUB:\n\
    \\fBaggageEntry\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2\DC4\n\
    \\ENQvalue\CAN\STX \SOH(\tR\ENQvalue:\STX8\SOH\"\212\SOH\n\
    \\bKeyValue\DC2\DLE\n\
    \\ETXkey\CAN\SOH \SOH(\tR\ETXkey\DC2#\n\
    \\fstring_value\CAN\STX \SOH(\tH\NULR\vstringValue\DC2!\n\
    \\tint_value\CAN\ETX \SOH(\ETXH\NULR\bintValueB\STX0\SOH\DC2#\n\
    \\fdouble_value\CAN\EOT \SOH(\SOHH\NULR\vdoubleValue\DC2\US\n\
    \\n\
    \bool_value\CAN\ENQ \SOH(\bH\NULR\tboolValue\DC2\US\n\
    \\n\
    \json_value\CAN\ACK \SOH(\tH\NULR\tjsonValueB\a\n\
    \\ENQvalue\"v\n\
    \\ETXLog\DC28\n\
    \\ttimestamp\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\ttimestamp\DC25\n\
    \\ACKfields\CAN\STX \ETX(\v2\GS.lightstep.collector.KeyValueR\ACKfields\"\209\SOH\n\
    \\tReference\DC2O\n\
    \\frelationship\CAN\SOH \SOH(\SO2+.lightstep.collector.Reference.RelationshipR\frelationship\DC2C\n\
    \\fspan_context\CAN\STX \SOH(\v2 .lightstep.collector.SpanContextR\vspanContext\".\n\
    \\fRelationship\DC2\f\n\
    \\bCHILD_OF\DLE\NUL\DC2\DLE\n\
    \\fFOLLOWS_FROM\DLE\SOH\"\133\ETX\n\
    \\EOTSpan\DC2C\n\
    \\fspan_context\CAN\SOH \SOH(\v2 .lightstep.collector.SpanContextR\vspanContext\DC2%\n\
    \\SOoperation_name\CAN\STX \SOH(\tR\roperationName\DC2>\n\
    \\n\
    \references\CAN\ETX \ETX(\v2\RS.lightstep.collector.ReferenceR\n\
    \references\DC2C\n\
    \\SIstart_timestamp\CAN\EOT \SOH(\v2\SUB.google.protobuf.TimestampR\SOstartTimestamp\DC2+\n\
    \\SIduration_micros\CAN\ENQ \SOH(\EOTR\SOdurationMicrosB\STX0\SOH\DC21\n\
    \\EOTtags\CAN\ACK \ETX(\v2\GS.lightstep.collector.KeyValueR\EOTtags\DC2,\n\
    \\EOTlogs\CAN\a \ETX(\v2\CAN.lightstep.collector.LogR\EOTlogs\"b\n\
    \\bReporter\DC2#\n\
    \\vreporter_id\CAN\SOH \SOH(\EOTR\n\
    \reporterIdB\STX0\SOH\DC21\n\
    \\EOTtags\CAN\EOT \ETX(\v2\GS.lightstep.collector.KeyValueR\EOTtags\"t\n\
    \\rMetricsSample\DC2\DC2\n\
    \\EOTname\CAN\SOH \SOH(\tR\EOTname\DC2!\n\
    \\tint_value\CAN\STX \SOH(\ETXH\NULR\bintValueB\STX0\SOH\DC2#\n\
    \\fdouble_value\CAN\ETX \SOH(\SOHH\NULR\vdoubleValueB\a\n\
    \\ENQvalue\"\169\STX\n\
    \\SIInternalMetrics\DC2C\n\
    \\SIstart_timestamp\CAN\SOH \SOH(\v2\SUB.google.protobuf.TimestampR\SOstartTimestamp\DC2+\n\
    \\SIduration_micros\CAN\STX \SOH(\EOTR\SOdurationMicrosB\STX0\SOH\DC2,\n\
    \\EOTlogs\CAN\ETX \ETX(\v2\CAN.lightstep.collector.LogR\EOTlogs\DC2:\n\
    \\ACKcounts\CAN\EOT \ETX(\v2\".lightstep.collector.MetricsSampleR\ACKcounts\DC2:\n\
    \\ACKgauges\CAN\ENQ \ETX(\v2\".lightstep.collector.MetricsSampleR\ACKgauges\")\n\
    \\EOTAuth\DC2!\n\
    \\faccess_token\CAN\SOH \SOH(\tR\vaccessToken\"\183\STX\n\
    \\rReportRequest\DC29\n\
    \\breporter\CAN\SOH \SOH(\v2\GS.lightstep.collector.ReporterR\breporter\DC2-\n\
    \\EOTauth\CAN\STX \SOH(\v2\EM.lightstep.collector.AuthR\EOTauth\DC2/\n\
    \\ENQspans\CAN\ETX \ETX(\v2\EM.lightstep.collector.SpanR\ENQspans\DC2:\n\
    \\ETBtimestamp_offset_micros\CAN\ENQ \SOH(\ETXR\NAKtimestampOffsetMicrosB\STX0\SOH\DC2O\n\
    \\DLEinternal_metrics\CAN\ACK \SOH(\v2$.lightstep.collector.InternalMetricsR\SIinternalMetrics\">\n\
    \\aCommand\DC2\CAN\n\
    \\adisable\CAN\SOH \SOH(\bR\adisable\DC2\EM\n\
    \\bdev_mode\CAN\STX \SOH(\bR\adevMode\"\168\STX\n\
    \\SOReportResponse\DC28\n\
    \\bcommands\CAN\SOH \ETX(\v2\FS.lightstep.collector.CommandR\bcommands\DC2G\n\
    \\DC1receive_timestamp\CAN\STX \SOH(\v2\SUB.google.protobuf.TimestampR\DLEreceiveTimestamp\DC2I\n\
    \\DC2transmit_timestamp\CAN\ETX \SOH(\v2\SUB.google.protobuf.TimestampR\DC1transmitTimestamp\DC2\SYN\n\
    \\ACKerrors\CAN\EOT \ETX(\tR\ACKerrors\DC2\SUB\n\
    \\bwarnings\CAN\ENQ \ETX(\tR\bwarnings\DC2\DC4\n\
    \\ENQinfos\CAN\ACK \ETX(\tR\ENQinfos2\149\SOH\n\
    \\DLECollectorService\DC2\128\SOH\n\
    \\ACKReport\DC2\".lightstep.collector.ReportRequest\SUB#.lightstep.collector.ReportResponse\"-\130\211\228\147\STX'\"\SI/api/v2/reports:\SOH*Z\DC1\DC2\SI/api/v2/reportsB1\n\
    \\EMcom.lightstep.tracer.grpcP\SOHZ\vcollectorpb\162\STX\EOTLSPBJ\195\GS\n\
    \\ACK\DC2\EOT\NUL\NULs\SOH\n\
    \\b\n\
    \\SOH\f\DC2\ETX\NUL\NUL\DC2\n\
    \\b\n\
    \\SOH\STX\DC2\ETX\STX\NUL\FS\n\
    \\b\n\
    \\SOH\b\DC2\ETX\EOT\NUL\"\n\
    \\t\n\
    \\STX\b\v\DC2\ETX\EOT\NUL\"\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ENQ\NUL\"\n\
    \\t\n\
    \\STX\b$\DC2\ETX\ENQ\NUL\"\n\
    \\b\n\
    \\SOH\b\DC2\ETX\ACK\NUL\"\n\
    \\t\n\
    \\STX\b\n\
    \\DC2\ETX\ACK\NUL\"\n\
    \\b\n\
    \\SOH\b\DC2\ETX\a\NUL2\n\
    \\t\n\
    \\STX\b\SOH\DC2\ETX\a\NUL2\n\
    \\t\n\
    \\STX\ETX\NUL\DC2\ETX\t\NUL)\n\
    \\t\n\
    \\STX\ETX\SOH\DC2\ETX\n\
    \\NUL&\n\
    \\n\
    \\n\
    \\STX\EOT\NUL\DC2\EOT\f\NUL\DLE\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\NUL\SOH\DC2\ETX\f\b\DC3\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\NUL\DC2\ETX\r\EOT+\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ENQ\DC2\ETX\r\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\SOH\DC2\ETX\r\v\DC3\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\ETX\DC2\ETX\r\SYN\ETB\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\NUL\b\DC2\ETX\r\CAN*\n\
    \\r\n\
    \\ACK\EOT\NUL\STX\NUL\b\ACK\DC2\ETX\r\EM)\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\SOH\DC2\ETX\SO\EOT*\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ENQ\DC2\ETX\SO\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\SOH\DC2\ETX\SO\v\DC2\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\ETX\DC2\ETX\SO\NAK\SYN\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\SOH\b\DC2\ETX\SO\ETB)\n\
    \\r\n\
    \\ACK\EOT\NUL\STX\SOH\b\ACK\DC2\ETX\SO\CAN(\n\
    \\v\n\
    \\EOT\EOT\NUL\STX\STX\DC2\ETX\SI\EOT$\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ACK\DC2\ETX\SI\EOT\ETB\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\SOH\DC2\ETX\SI\CAN\US\n\
    \\f\n\
    \\ENQ\EOT\NUL\STX\STX\ETX\DC2\ETX\SI\"#\n\
    \1\n\
    \\STX\EOT\SOH\DC2\EOT\DC3\NUL \SOH\SUB% Represent both tags and log fields.\n\
    \\n\
    \\n\
    \\n\
    \\ETX\EOT\SOH\SOH\DC2\ETX\DC3\b\DLE\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\NUL\DC2\ETX\DC4\EOT\DC3\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ENQ\DC2\ETX\DC4\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\SOH\DC2\ETX\DC4\v\SO\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\NUL\ETX\DC2\ETX\DC4\DC1\DC2\n\
    \\f\n\
    \\EOT\EOT\SOH\b\NUL\DC2\EOT\NAK\EOT\US\ENQ\n\
    \\f\n\
    \\ENQ\EOT\SOH\b\NUL\SOH\DC2\ETX\NAK\n\
    \\SI\n\
    \^\n\
    \\EOT\EOT\SOH\STX\SOH\DC2\ETX\CAN\b \SUBQ Holds arbitrary string data; well-formed JSON strings should go in\n\
    \ json_value.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ENQ\DC2\ETX\CAN\b\SO\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\SOH\DC2\ETX\CAN\SI\ESC\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\SOH\ETX\DC2\ETX\CAN\RS\US\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\STX\DC2\ETX\EM\b/\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ENQ\DC2\ETX\EM\b\r\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\SOH\DC2\ETX\EM\SO\ETB\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\ETX\DC2\ETX\EM\SUB\ESC\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\STX\b\DC2\ETX\EM\FS.\n\
    \\r\n\
    \\ACK\EOT\SOH\STX\STX\b\ACK\DC2\ETX\EM\GS-\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\ETX\DC2\ETX\SUB\b \n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\ENQ\DC2\ETX\SUB\b\SO\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\SOH\DC2\ETX\SUB\SI\ESC\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ETX\ETX\DC2\ETX\SUB\RS\US\n\
    \\v\n\
    \\EOT\EOT\SOH\STX\EOT\DC2\ETX\ESC\b\FS\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\ENQ\DC2\ETX\ESC\b\f\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\SOH\DC2\ETX\ESC\r\ETB\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\EOT\ETX\DC2\ETX\ESC\SUB\ESC\n\
    \x\n\
    \\EOT\EOT\SOH\STX\ENQ\DC2\ETX\RS\b\RS\SUBk Must be a well-formed JSON value. Truncated JSON should go in\n\
    \ string_value. Should not be used for tags.\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ENQ\ENQ\DC2\ETX\RS\b\SO\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ENQ\SOH\DC2\ETX\RS\SI\EM\n\
    \\f\n\
    \\ENQ\EOT\SOH\STX\ENQ\ETX\DC2\ETX\RS\FS\GS\n\
    \\n\
    \\n\
    \\STX\EOT\STX\DC2\EOT\"\NUL%\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\STX\SOH\DC2\ETX\"\b\v\n\
    \\v\n\
    \\EOT\EOT\STX\STX\NUL\DC2\ETX#\EOT,\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ACK\DC2\ETX#\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\SOH\DC2\ETX#\RS'\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\NUL\ETX\DC2\ETX#*+\n\
    \\v\n\
    \\EOT\EOT\STX\STX\SOH\DC2\ETX$\EOT!\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\EOT\DC2\ETX$\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ACK\DC2\ETX$\r\NAK\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\SOH\DC2\ETX$\SYN\FS\n\
    \\f\n\
    \\ENQ\EOT\STX\STX\SOH\ETX\DC2\ETX$\US \n\
    \\n\
    \\n\
    \\STX\EOT\ETX\DC2\EOT'\NUL.\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ETX\SOH\DC2\ETX'\b\DC1\n\
    \\f\n\
    \\EOT\EOT\ETX\EOT\NUL\DC2\EOT(\EOT+\ENQ\n\
    \\f\n\
    \\ENQ\EOT\ETX\EOT\NUL\SOH\DC2\ETX(\t\NAK\n\
    \\r\n\
    \\ACK\EOT\ETX\EOT\NUL\STX\NUL\DC2\ETX)\b\NAK\n\
    \\SO\n\
    \\a\EOT\ETX\EOT\NUL\STX\NUL\SOH\DC2\ETX)\b\DLE\n\
    \\SO\n\
    \\a\EOT\ETX\EOT\NUL\STX\NUL\STX\DC2\ETX)\DC3\DC4\n\
    \\r\n\
    \\ACK\EOT\ETX\EOT\NUL\STX\SOH\DC2\ETX*\b\EM\n\
    \\SO\n\
    \\a\EOT\ETX\EOT\NUL\STX\SOH\SOH\DC2\ETX*\b\DC4\n\
    \\SO\n\
    \\a\EOT\ETX\EOT\NUL\STX\SOH\STX\DC2\ETX*\ETB\CAN\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\NUL\DC2\ETX,\EOT\"\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ACK\DC2\ETX,\EOT\DLE\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\SOH\DC2\ETX,\DC1\GS\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\NUL\ETX\DC2\ETX, !\n\
    \\v\n\
    \\EOT\EOT\ETX\STX\SOH\DC2\ETX-\EOT!\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ACK\DC2\ETX-\EOT\SI\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\SOH\DC2\ETX-\DLE\FS\n\
    \\f\n\
    \\ENQ\EOT\ETX\STX\SOH\ETX\DC2\ETX-\US \n\
    \\n\
    \\n\
    \\STX\EOT\EOT\DC2\EOT0\NUL8\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\EOT\SOH\DC2\ETX0\b\f\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\NUL\DC2\ETX1\EOT!\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ACK\DC2\ETX1\EOT\SI\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\SOH\DC2\ETX1\DLE\FS\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\NUL\ETX\DC2\ETX1\US \n\
    \\v\n\
    \\EOT\EOT\EOT\STX\SOH\DC2\ETX2\EOT\RS\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\ENQ\DC2\ETX2\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\SOH\DC2\ETX2\v\EM\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\SOH\ETX\DC2\ETX2\FS\GS\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\STX\DC2\ETX3\EOT&\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\STX\EOT\DC2\ETX3\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\STX\ACK\DC2\ETX3\r\SYN\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\STX\SOH\DC2\ETX3\ETB!\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\STX\ETX\DC2\ETX3$%\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\ETX\DC2\ETX4\EOT2\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ETX\ACK\DC2\ETX4\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ETX\SOH\DC2\ETX4\RS-\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ETX\ETX\DC2\ETX401\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\EOT\DC2\ETX5\EOT2\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\EOT\ENQ\DC2\ETX5\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\EOT\SOH\DC2\ETX5\v\SUB\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\EOT\ETX\DC2\ETX5\GS\RS\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\EOT\b\DC2\ETX5\US1\n\
    \\r\n\
    \\ACK\EOT\EOT\STX\EOT\b\ACK\DC2\ETX5 0\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\ENQ\DC2\ETX6\EOT\US\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ENQ\EOT\DC2\ETX6\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ENQ\ACK\DC2\ETX6\r\NAK\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ENQ\SOH\DC2\ETX6\SYN\SUB\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ENQ\ETX\DC2\ETX6\GS\RS\n\
    \\v\n\
    \\EOT\EOT\EOT\STX\ACK\DC2\ETX7\EOT\SUB\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ACK\EOT\DC2\ETX7\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ACK\ACK\DC2\ETX7\r\DLE\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ACK\SOH\DC2\ETX7\DC1\NAK\n\
    \\f\n\
    \\ENQ\EOT\EOT\STX\ACK\ETX\DC2\ETX7\CAN\EM\n\
    \\n\
    \\n\
    \\STX\EOT\ENQ\DC2\EOT:\NUL=\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ENQ\SOH\DC2\ETX:\b\DLE\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\NUL\DC2\ETX;\EOT.\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ENQ\DC2\ETX;\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\SOH\DC2\ETX;\v\SYN\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\ETX\DC2\ETX;\EM\SUB\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\NUL\b\DC2\ETX;\ESC-\n\
    \\r\n\
    \\ACK\EOT\ENQ\STX\NUL\b\ACK\DC2\ETX;\FS,\n\
    \\v\n\
    \\EOT\EOT\ENQ\STX\SOH\DC2\ETX<\EOT\US\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\EOT\DC2\ETX<\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\ACK\DC2\ETX<\r\NAK\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\SOH\DC2\ETX<\SYN\SUB\n\
    \\f\n\
    \\ENQ\EOT\ENQ\STX\SOH\ETX\DC2\ETX<\GS\RS\n\
    \\n\
    \\n\
    \\STX\EOT\ACK\DC2\EOT?\NULE\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\ACK\SOH\DC2\ETX?\b\NAK\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\NUL\DC2\ETX@\EOT\DC4\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ENQ\DC2\ETX@\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\SOH\DC2\ETX@\v\SI\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\NUL\ETX\DC2\ETX@\DC2\DC3\n\
    \\f\n\
    \\EOT\EOT\ACK\b\NUL\DC2\EOTA\EOTD\ENQ\n\
    \\f\n\
    \\ENQ\EOT\ACK\b\NUL\SOH\DC2\ETXA\n\
    \\SI\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\SOH\DC2\ETXB\b/\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ENQ\DC2\ETXB\b\r\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\SOH\DC2\ETXB\SO\ETB\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\ETX\DC2\ETXB\SUB\ESC\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\SOH\b\DC2\ETXB\FS.\n\
    \\r\n\
    \\ACK\EOT\ACK\STX\SOH\b\ACK\DC2\ETXB\GS-\n\
    \\v\n\
    \\EOT\EOT\ACK\STX\STX\DC2\ETXC\b \n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\STX\ENQ\DC2\ETXC\b\SO\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\STX\SOH\DC2\ETXC\SI\ESC\n\
    \\f\n\
    \\ENQ\EOT\ACK\STX\STX\ETX\DC2\ETXC\RS\US\n\
    \\n\
    \\n\
    \\STX\EOT\a\DC2\EOTG\NULM\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\a\SOH\DC2\ETXG\b\ETB\n\
    \\v\n\
    \\EOT\EOT\a\STX\NUL\DC2\ETXH\EOT2\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ACK\DC2\ETXH\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\SOH\DC2\ETXH\RS-\n\
    \\f\n\
    \\ENQ\EOT\a\STX\NUL\ETX\DC2\ETXH01\n\
    \\v\n\
    \\EOT\EOT\a\STX\SOH\DC2\ETXI\EOT2\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\ENQ\DC2\ETXI\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\SOH\DC2\ETXI\v\SUB\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\ETX\DC2\ETXI\GS\RS\n\
    \\f\n\
    \\ENQ\EOT\a\STX\SOH\b\DC2\ETXI\US1\n\
    \\r\n\
    \\ACK\EOT\a\STX\SOH\b\ACK\DC2\ETXI 0\n\
    \\v\n\
    \\EOT\EOT\a\STX\STX\DC2\ETXJ\EOT\SUB\n\
    \\f\n\
    \\ENQ\EOT\a\STX\STX\EOT\DC2\ETXJ\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\a\STX\STX\ACK\DC2\ETXJ\r\DLE\n\
    \\f\n\
    \\ENQ\EOT\a\STX\STX\SOH\DC2\ETXJ\DC1\NAK\n\
    \\f\n\
    \\ENQ\EOT\a\STX\STX\ETX\DC2\ETXJ\CAN\EM\n\
    \\v\n\
    \\EOT\EOT\a\STX\ETX\DC2\ETXK\EOT&\n\
    \\f\n\
    \\ENQ\EOT\a\STX\ETX\EOT\DC2\ETXK\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\a\STX\ETX\ACK\DC2\ETXK\r\SUB\n\
    \\f\n\
    \\ENQ\EOT\a\STX\ETX\SOH\DC2\ETXK\ESC!\n\
    \\f\n\
    \\ENQ\EOT\a\STX\ETX\ETX\DC2\ETXK$%\n\
    \\v\n\
    \\EOT\EOT\a\STX\EOT\DC2\ETXL\EOT&\n\
    \\f\n\
    \\ENQ\EOT\a\STX\EOT\EOT\DC2\ETXL\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\a\STX\EOT\ACK\DC2\ETXL\r\SUB\n\
    \\f\n\
    \\ENQ\EOT\a\STX\EOT\SOH\DC2\ETXL\ESC!\n\
    \\f\n\
    \\ENQ\EOT\a\STX\EOT\ETX\DC2\ETXL$%\n\
    \\n\
    \\n\
    \\STX\EOT\b\DC2\EOTO\NULQ\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\b\SOH\DC2\ETXO\b\f\n\
    \\v\n\
    \\EOT\EOT\b\STX\NUL\DC2\ETXP\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\ENQ\DC2\ETXP\EOT\n\
    \\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\SOH\DC2\ETXP\v\ETB\n\
    \\f\n\
    \\ENQ\EOT\b\STX\NUL\ETX\DC2\ETXP\SUB\ESC\n\
    \\n\
    \\n\
    \\STX\EOT\t\DC2\EOTS\NULY\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\t\SOH\DC2\ETXS\b\NAK\n\
    \\v\n\
    \\EOT\EOT\t\STX\NUL\DC2\ETXT\EOT\SUB\n\
    \\f\n\
    \\ENQ\EOT\t\STX\NUL\ACK\DC2\ETXT\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\t\STX\NUL\SOH\DC2\ETXT\r\NAK\n\
    \\f\n\
    \\ENQ\EOT\t\STX\NUL\ETX\DC2\ETXT\CAN\EM\n\
    \\v\n\
    \\EOT\EOT\t\STX\SOH\DC2\ETXU\EOT\DC2\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SOH\ACK\DC2\ETXU\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SOH\SOH\DC2\ETXU\t\r\n\
    \\f\n\
    \\ENQ\EOT\t\STX\SOH\ETX\DC2\ETXU\DLE\DC1\n\
    \\v\n\
    \\EOT\EOT\t\STX\STX\DC2\ETXV\EOT\FS\n\
    \\f\n\
    \\ENQ\EOT\t\STX\STX\EOT\DC2\ETXV\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\t\STX\STX\ACK\DC2\ETXV\r\DC1\n\
    \\f\n\
    \\ENQ\EOT\t\STX\STX\SOH\DC2\ETXV\DC2\ETB\n\
    \\f\n\
    \\ENQ\EOT\t\STX\STX\ETX\DC2\ETXV\SUB\ESC\n\
    \\v\n\
    \\EOT\EOT\t\STX\ETX\DC2\ETXW\EOT9\n\
    \\f\n\
    \\ENQ\EOT\t\STX\ETX\ENQ\DC2\ETXW\EOT\t\n\
    \\f\n\
    \\ENQ\EOT\t\STX\ETX\SOH\DC2\ETXW\n\
    \!\n\
    \\f\n\
    \\ENQ\EOT\t\STX\ETX\ETX\DC2\ETXW$%\n\
    \\f\n\
    \\ENQ\EOT\t\STX\ETX\b\DC2\ETXW&8\n\
    \\r\n\
    \\ACK\EOT\t\STX\ETX\b\ACK\DC2\ETXW'7\n\
    \\v\n\
    \\EOT\EOT\t\STX\EOT\DC2\ETXX\EOT)\n\
    \\f\n\
    \\ENQ\EOT\t\STX\EOT\ACK\DC2\ETXX\EOT\DC3\n\
    \\f\n\
    \\ENQ\EOT\t\STX\EOT\SOH\DC2\ETXX\DC4$\n\
    \\f\n\
    \\ENQ\EOT\t\STX\EOT\ETX\DC2\ETXX'(\n\
    \\n\
    \\n\
    \\STX\EOT\n\
    \\DC2\EOT[\NUL^\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\n\
    \\SOH\DC2\ETX[\b\SI\n\
    \\v\n\
    \\EOT\EOT\n\
    \\STX\NUL\DC2\ETX\\\EOT\NAK\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ENQ\DC2\ETX\\\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\SOH\DC2\ETX\\\t\DLE\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\NUL\ETX\DC2\ETX\\\DC3\DC4\n\
    \\v\n\
    \\EOT\EOT\n\
    \\STX\SOH\DC2\ETX]\EOT\SYN\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\SOH\ENQ\DC2\ETX]\EOT\b\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\SOH\SOH\DC2\ETX]\t\DC1\n\
    \\f\n\
    \\ENQ\EOT\n\
    \\STX\SOH\ETX\DC2\ETX]\DC4\NAK\n\
    \\n\
    \\n\
    \\STX\EOT\v\DC2\EOT`\NULg\SOH\n\
    \\n\
    \\n\
    \\ETX\EOT\v\SOH\DC2\ETX`\b\SYN\n\
    \\v\n\
    \\EOT\EOT\v\STX\NUL\DC2\ETXa\EOT\"\n\
    \\f\n\
    \\ENQ\EOT\v\STX\NUL\EOT\DC2\ETXa\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\v\STX\NUL\ACK\DC2\ETXa\r\DC4\n\
    \\f\n\
    \\ENQ\EOT\v\STX\NUL\SOH\DC2\ETXa\NAK\GS\n\
    \\f\n\
    \\ENQ\EOT\v\STX\NUL\ETX\DC2\ETXa !\n\
    \\v\n\
    \\EOT\EOT\v\STX\SOH\DC2\ETXb\EOT4\n\
    \\f\n\
    \\ENQ\EOT\v\STX\SOH\ACK\DC2\ETXb\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\v\STX\SOH\SOH\DC2\ETXb\RS/\n\
    \\f\n\
    \\ENQ\EOT\v\STX\SOH\ETX\DC2\ETXb23\n\
    \\v\n\
    \\EOT\EOT\v\STX\STX\DC2\ETXc\EOT5\n\
    \\f\n\
    \\ENQ\EOT\v\STX\STX\ACK\DC2\ETXc\EOT\GS\n\
    \\f\n\
    \\ENQ\EOT\v\STX\STX\SOH\DC2\ETXc\RS0\n\
    \\f\n\
    \\ENQ\EOT\v\STX\STX\ETX\DC2\ETXc34\n\
    \\v\n\
    \\EOT\EOT\v\STX\ETX\DC2\ETXd\EOT\US\n\
    \\f\n\
    \\ENQ\EOT\v\STX\ETX\EOT\DC2\ETXd\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\v\STX\ETX\ENQ\DC2\ETXd\r\DC3\n\
    \\f\n\
    \\ENQ\EOT\v\STX\ETX\SOH\DC2\ETXd\DC4\SUB\n\
    \\f\n\
    \\ENQ\EOT\v\STX\ETX\ETX\DC2\ETXd\GS\RS\n\
    \\v\n\
    \\EOT\EOT\v\STX\EOT\DC2\ETXe\EOT!\n\
    \\f\n\
    \\ENQ\EOT\v\STX\EOT\EOT\DC2\ETXe\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\v\STX\EOT\ENQ\DC2\ETXe\r\DC3\n\
    \\f\n\
    \\ENQ\EOT\v\STX\EOT\SOH\DC2\ETXe\DC4\FS\n\
    \\f\n\
    \\ENQ\EOT\v\STX\EOT\ETX\DC2\ETXe\US \n\
    \\v\n\
    \\EOT\EOT\v\STX\ENQ\DC2\ETXf\EOT\RS\n\
    \\f\n\
    \\ENQ\EOT\v\STX\ENQ\EOT\DC2\ETXf\EOT\f\n\
    \\f\n\
    \\ENQ\EOT\v\STX\ENQ\ENQ\DC2\ETXf\r\DC3\n\
    \\f\n\
    \\ENQ\EOT\v\STX\ENQ\SOH\DC2\ETXf\DC4\EM\n\
    \\f\n\
    \\ENQ\EOT\v\STX\ENQ\ETX\DC2\ETXf\FS\GS\n\
    \\n\
    \\n\
    \\STX\ACK\NUL\DC2\EOTi\NULs\SOH\n\
    \\n\
    \\n\
    \\ETX\ACK\NUL\SOH\DC2\ETXi\b\CAN\n\
    \\f\n\
    \\EOT\ACK\NUL\STX\NUL\DC2\EOTj\EOTr\ENQ\n\
    \\f\n\
    \\ENQ\ACK\NUL\STX\NUL\SOH\DC2\ETXj\b\SO\n\
    \\f\n\
    \\ENQ\ACK\NUL\STX\NUL\STX\DC2\ETXj\SI\FS\n\
    \\f\n\
    \\ENQ\ACK\NUL\STX\NUL\ETX\DC2\ETXj'5\n\
    \\r\n\
    \\ENQ\ACK\NUL\STX\NUL\EOT\DC2\EOTk\aq\t\n\
    \\DC1\n\
    \\t\ACK\NUL\STX\NUL\EOT\176\202\188\"\DC2\EOTk\aq\tb\ACKproto3"