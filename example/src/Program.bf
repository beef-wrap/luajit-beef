using System;
using System.Diagnostics;
using System.IO;
using static luajit_Beef.luajit;

namespace example;

static class Program
{
	static int Main(params String[] args)
	{
		lua_State* L = luaL_newstate(); // open Lua

		luaL_openlibs(L);

		if (L == null)
		{
			return -1; // Checks that Lua started up
		}

		lua_CFunction hello_func = (L) =>
			{
				Debug.WriteLine("hello");
				return 0;
			};

		luaL_Reg hello_func_reg = .() { name = "hello", func = hello_func };

		luaL_register(L, "my_module", &hello_func_reg);

		luaL_loadstring(L, "my_module.hello()");

		int ret = lua_pcall(L, 0, 0, 0); // tell Lua to run the script

		if (ret != 0)
		{
			Debug.WriteLine(StringView(lua_tostring(L, -1))); // tell us what mistake we made
			return 1;
		}

		lua_close(L); // Close Lua

		return 0;
	}
}