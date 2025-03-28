/*
** LuaJIT -- a Just-In-Time Compiler for Lua. https://luajit.org/
**
** Copyright (C) 2005-2025 Mike Pall. All rights reserved.
**
** Permission is hereby granted, free of charge, to any person obtaining
** a copy of this software and associated documentation files (the
** "Software"), to deal in the Software without restriction, including
** without limitation the rights to use, copy, modify, merge, publish,
** distribute, sublicense, and/or sell copies of the Software, and to
** permit persons to whom the Software is furnished to do so, subject to
** the following conditions:
**
** The above copyright notice and this permission notice shall be
** included in all copies or substantial portions of the Software.
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
** EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
** MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
** IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
** CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
** TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
** SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
**
** [ MIT license: https://www.opensource.org/licenses/mit-license.php ]
*/

using System;
using System.Interop;

namespace luajit_Beef;

public static class luajit
{
	public const c_char* LUAJIT_VERSION		= "LuaJIT 2.1.1736781742";
	public const c_int LUAJIT_VERSION_NUM    	= 20199; /* Deprecated. */;
	public const c_char* LUAJIT_COPYRIGHT		= "Copyright (C) 2005-2025 Mike Pall";
	public const c_char* LUAJIT_URL			= "https://luajit.org/";

	/* Modes for luaJIT_setmode. */
	public const c_int LUAJIT_MODE_MASK = 0x00ff;

	public enum luajit_mode : c_int
	{
		LUAJIT_MODE_ENGINE, /* Set mode for whole JIT engine. */
		LUAJIT_MODE_DEBUG, /* Set debug mode (idx = level). */

		LUAJIT_MODE_FUNC, /* Change mode for a function. */
		LUAJIT_MODE_ALLFUNC, /* Recurse into subroutine protos. */
		LUAJIT_MODE_ALLSUBFUNC, /* Change only the subroutines. */

		LUAJIT_MODE_TRACE, /* Flush a compiled trace. */

		LUAJIT_MODE_WRAPCFUNC = 0x10, /* Set wrapper mode for C function calls. */

		LUAJIT_MODE_MAX
	}

	/* Flags or'ed in to the mode. */
	public const c_int LUAJIT_MODE_OFF	 = 0x0000; /* Turn feature off. */
	public const c_int LUAJIT_MODE_ON	 = 0x0100; /* Turn feature on. */
	public const c_int LUAJIT_MODE_FLUSH	 = 0x0200; /* Flush JIT-compiled code. */

	/* LuaJIT public C API. */

	/* Control the JIT engine. */
	[CLink] public static extern c_int luaJIT_setmode(lua_State* L, c_int idx, c_int mode);

	/* Low-overhead profiling API. */
	function void luaJIT_profile_callback(void* data, lua_State* L, c_int samples, c_int vmstate);

	[CLink] public static extern void luaJIT_profile_start(lua_State* L, char* mode, luaJIT_profile_callback cb, void* data);
	[CLink] public static extern void luaJIT_profile_stop(lua_State* L);
	[CLink] public static extern char* luaJIT_profile_dumpstack(lua_State* L, char* fmt, c_int depth, size_t* len);

	/* Enforce (dynamic) linker error for version mismatches. Call from main. */
	[CLink] public static extern void LUAJIT_VERSION_SYM();
}