using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LuaInterface;
using slf4net;
namespace dotNetty
{
    class ConsumerManager
    {

        private static ILogger logger = LoggerFactory.GetLogger(typeof(ConsumerManager));

        //该方法为lua调用
        public static void SendMessage(Object message)
        {

            ConsumerFrame frame = new ConsumerFrame();
            frame.Message = message;
            Console.WriteLine("message:"+message);
            Console.WriteLine("frame.Message:" + frame.Message);
            //一些判断就先不写了
            ConsumerContext.channel.WriteAndFlushAsync(frame);

        }

        public static void Print(Object msg)
        {

            logger.Debug(msg.ToString());
        }
    }
}
