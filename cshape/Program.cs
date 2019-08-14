using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using DotNetty.Buffers;
using DotNetty.Codecs.Protobuf;
using Google.ProtocolBuffers;
using log4net;
using LuaInterface;

namespace dotNetty
{
    static class Program
    {

      static slf4net.ILogger logger = slf4net.LoggerFactory.GetLogger(typeof(Program));
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {

            //Application.EnableVisualStyles();
            // Application.SetCompatibleTextRenderingDefault(false);
            // Application.Run(new Form1());
           // BufferTest.a();
           // System.Threading.Thread.Sleep(1000000);
            ConsumerContext.Init();
            ConsumerContext.lua.RegisterFunction("print", null, typeof(ConsumerManager).GetMethod("Print"));
            EchoClient.RunClientAsync().Wait();

     
           // System.Threading.Thread.CurrentThread.Suspend();
            System.Threading.Thread.Sleep(1000000);
             CodedInputStream d;
             CodedOutputStream b;
            ProtobufVarint32FrameDecoder c;

            // Console.WriteLine(Application.StartupPath);

            // Student student = new Student();

            Lua lua = new Lua();

            //lua.RegisterFunction("MethodA", student, student.GetType().GetMethod("MethodA"));
            lua.RegisterFunction("print", null, typeof(ConsumerManager).GetMethod("Print"));
            lua.DoFile("lua/LuaObj.lua");
            lua.RegisterFunction("print", null, typeof(ConsumerManager).GetMethod("Print"));
            // string path = "lua/com/senpure/io/ConsumerDecoder.lua";

            LuaFunction func = lua.GetFunction("hello");

            func.Call(new Student());
          
           // System.Threading.Thread.CurrentThread.Suspend();

        }
    }
}
