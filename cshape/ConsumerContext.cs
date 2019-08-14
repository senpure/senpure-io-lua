using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using DotNetty.Transport.Channels;
using LuaInterface;

namespace dotNetty
{
    class ConsumerContext
    {

        public static Lua lua;

        public static LuaFunction luaStartTestFun;
        public static LuaFunction luaMessageEncodeFun;
        public static LuaFunction luaMessageDecodeFun;
        public static IChannel channel;
        public static void Init()
        {

            lua = new Lua();
           
            lua.RegisterFunction("CShapeSendMessage", null, typeof(ConsumerManager).GetMethod("SendMessage"));
            string path = "lua/com/senpure/io/Require.lua";
            lua.DoFile(path);
            luaStartTestFun = lua.GetFunction("ConsumerStart.start");
            luaMessageEncodeFun = lua.GetFunction("ConsumerManager.CShapeCallEncodeMessage");
            luaMessageDecodeFun= lua.GetFunction("ConsumerManager.CShapeCallDecodeMessage");


        }
       
    }
}
