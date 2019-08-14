using System;
using DotNetty.Transport.Channels;
using slf4net;

namespace dotNetty
{
    class ConsumerHandler : SimpleChannelInboundHandler<ConsumerBuffer>
    {
        private static ILogger logger = LoggerFactory.GetLogger(typeof(ConsumerHandler));
        public override void ChannelActive(IChannelHandlerContext context)
        {
            ConsumerContext.channel = context.Channel;
            if (ConsumerContext.luaStartTestFun != null)
            {
                ConsumerContext.luaStartTestFun.Call();
            }
            else {

               logger.Debug("没有测试函数");
            }
  

        }

     

        protected override void ChannelRead0(IChannelHandlerContext ctx, ConsumerBuffer msg)
        {
            logger.Debug("收到返回消息");
            ConsumerContext.luaMessageDecodeFun.Call(msg,msg.EndIndex);
        }
    }
}
