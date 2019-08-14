using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DotNetty.Buffers;
using DotNetty.Codecs;
using DotNetty.Transport.Channels;
using slf4net;

namespace dotNetty
{
    class ConsumerEncoder : MessageToByteEncoder<ConsumerFrame>
    {
        private static ILogger logger = LoggerFactory.GetLogger(typeof(ConsumerEncoder));
        protected override void Encode(IChannelHandlerContext context, ConsumerFrame message, IByteBuffer output)
        {

            ConsumerBuffer buffer = new ConsumerBuffer();
            buffer.Buffer = output;

            ConsumerContext.luaMessageEncodeFun.Call(buffer,message.Message);
           
           
        }
    }
}
