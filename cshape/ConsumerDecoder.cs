using System;
using System.Collections.Generic;
using DotNetty.Buffers;
using DotNetty.Codecs;
using DotNetty.Transport.Channels;
using slf4net;
namespace dotNetty
{
    class ConsumerDecoder : ByteToMessageDecoder
    {

        private static ILogger logger = LoggerFactory.GetLogger(typeof(ConsumerDecoder));

        protected override void Decode(IChannelHandlerContext context, IByteBuffer input, List<object> output)
        {
            input.MarkReaderIndex();
            int readerIndex = input.ReaderIndex;
            int packageLength = ConsumerBuffer.TryReadVar32(input);
            if (readerIndex == input.ReaderIndex)
            {
                return;
            }
            if (packageLength == 0)
            {
                throw new Exception("包长度不能为0");
            }

            //半包
            if (packageLength > input.ReadableBytes)
            {
                logger.Debug("数据不够一个数据包 pl={} ,rl={}", packageLength, input.ReadableBytes);
                input.ResetReaderIndex();
            }
            else
            {
                IByteBuffer buffer = input.ReadBytes(packageLength);
                ConsumerBuffer consumerBuffer = new ConsumerBuffer();
                consumerBuffer.Buffer = buffer;
                consumerBuffer.EndIndex = buffer.WriterIndex;
                output.Add(consumerBuffer);

            }
        }
        protected void Decode2(IChannelHandlerContext context, IByteBuffer input, List<object> output)
        {

            int readable = input.ReadableBytes;
            if (readable < 4)
            {
                logger.Debug("数据过短 {}", readable);
                return;
            }
            input.MarkReaderIndex();
            int packageLength = input.ReadInt();
            if (packageLength == 0)
            {
                throw new Exception("包长度不能为0");
            }
            //半包
            if (packageLength > input.ReadableBytes)
            {
                logger.Debug("数据不够一个数据包 pl={} ,rl={}", packageLength, input.ReadableBytes);
                input.ResetReaderIndex();
            }
            else
            {
                IByteBuffer buffer = input.ReadBytes(packageLength);
                ConsumerBuffer consumerBuffer = new ConsumerBuffer();
                consumerBuffer.Buffer = buffer;
                consumerBuffer.EndIndex = buffer.WriterIndex;
                output.Add(consumerBuffer);

            }


        }

    }
}
