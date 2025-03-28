/******************************************************************************
* Copyright (C) 1994-2008 Lua.org, PUC-Rio.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining
* a copy of this software and associated documentation files (the
* "Software"), to deal in the Software without restriction, including
* without limitation the rights to use, copy, modify, merge, publish,
* distribute, sublicense, and/or sell copies of the Software, and to
* permit persons to whom the Software is furnished to do so, subject to
* the following conditions:
*
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
* MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
* IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
* CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
* TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
* SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
******************************************************************************/

using System;
using System.Interop;

namespace luajit_Beef;

extension luajit
{
	typealias char = c_char;
	typealias size_t = uint;

	public typealias ptrdiff_t = int64;
	public typealias intptr_t = int64;

	public typealias LUA_INTEGER			= intptr_t;

	public const c_int BUFSIZ 				=  512;
	public const c_int LUAL_BUFFERSIZE		= BUFSIZ > 16384 ? 8192 : BUFSIZ;

	public typealias LUA_NUMBER				= double;
	public typealias LUAI_UACNUMBER			= double;

	public const char* LUA_NUMBER_SCAN		= "%lf";
	public const char* LUA_NUMBER_FMT		= "%.14g";
	public const c_int LUAI_MAXNUMBER2STR	= 32;
	public const char* LUA_INTFRMLEN		= "l";

	public typealias LUA_INTFRM_T			= double;

	public const char* LUA_VERSION			= "Lua 5.1";
	public const char* LUA_RELEASE			= "Lua 5.1.4";
	public const c_int LUA_VERSION_NUM		= 501;
	public const char* LUA_COPYRIGHT		= "Copyright (C) 1994-2008 Lua.org, PUC-Rio";
	public const char* LUA_AUTHORS			= "R. Ierusalimschy, L. H. de Figueiredo & W. Celes";

	/* mark for precompiled code (`<esc>Lua') */
	public const char* LUA_SIGNATURE 	= "\033Lua";

	/* option for multiple returns in `lua_pcall' and `lua_call' */
	public const c_int LUA_MULTRET	= (-1);

	/*
	** pseudo-indices
	*/
	public const c_int LUA_REGISTRYINDEX	= (-10000);
	public const c_int LUA_ENVIRONINDEX	= (-10001);
	public const c_int LUA_GLOBALSINDEX	= (-10002);
	// const c_int lua_upvalueindex(i)	= (LUA_GLOBALSINDEX-(i));


	/* thread status */
	public const c_int LUA_OK		= 0;
	public const c_int LUA_YIELD		= 1;
	public const c_int LUA_ERRRUN	= 2;
	public const c_int LUA_ERRSYNTAX	= 3;
	public const c_int LUA_ERRMEM	= 4;
	public const c_int LUA_ERRERR	= 5;


	public struct lua_State;

	public function c_int lua_CFunction(lua_State* L);

	/*
	** functions that read/write blocks when loading/dumping Lua chunks
	*/
	public function char* lua_Reader(lua_State* L, void* ud, size_t* sz);

	public function c_int lua_Writer(lua_State* L, void* p, size_t sz, void* ud);


	/*
	** prototype for memory-allocation functions
	*/
	public function void* lua_Alloc(void* ud, void* ptr, size_t osize, size_t nsize);


	/*
	** basic types
	*/
	public const c_int LUA_TNONE			 	= (-1);

	public const c_int LUA_TNIL					= 0;
	public const c_int LUA_TBOOLEAN				= 1;
	public const c_int LUA_TLIGHTUSERDATA		= 2;
	public const c_int LUA_TNUMBER				= 3;
	public const c_int LUA_TSTRING				= 4;
	public const c_int LUA_TTABLE				= 5;
	public const c_int LUA_TFUNCTION			= 6;
	public const c_int LUA_TUSERDATA			= 7;
	public const c_int LUA_TTHREAD				= 8;

	/* minimum Lua stack available to a C function */
	public const c_int LUA_MINSTACK				= 20;

	/*
	** generic extra include file
	*/
	// #if defined(LUA_USER_H)
	// #include LUA_USER_H
	// #endif


	/* type of numbers in Lua */
	public typealias lua_Number = LUA_NUMBER;

	/* type for integer functions */
	public typealias lua_Integer = LUA_INTEGER;

	/*
	** state manipulation
	*/
	[CLink] public static extern lua_State* lua_newstate(lua_Alloc f, void* ud);
	[CLink] public static extern void lua_close(lua_State* L);
	[CLink] public static extern lua_State* lua_newthread(lua_State* L);

	[CLink] public static extern lua_CFunction lua_atpanic(lua_State* L, lua_CFunction panicf);


	/*
	** basic stack manipulation
	*/
	[CLink] public static extern c_int lua_gettop(lua_State* L);
	[CLink] public static extern void lua_settop(lua_State* L, c_int idx);
	[CLink] public static extern void lua_pushvalue(lua_State* L, c_int idx);
	[CLink] public static extern void lua_remove(lua_State* L, c_int idx);
	[CLink] public static extern void lua_insert(lua_State* L, c_int idx);
	[CLink] public static extern void lua_replace(lua_State* L, c_int idx);
	[CLink] public static extern c_int lua_checkstack(lua_State* L, c_int sz);

	[CLink] public static extern void lua_xmove(lua_State* from, lua_State* to, c_int n);


	/*
	** access functions (stack -> C)
	*/

	[CLink] public static extern c_int lua_isnumber(lua_State* L, c_int idx);
	[CLink] public static extern c_int lua_isstring(lua_State* L, c_int idx);
	[CLink] public static extern c_int lua_iscfunction(lua_State* L, c_int idx);
	[CLink] public static extern c_int lua_isuserdata(lua_State* L, c_int idx);
	[CLink] public static extern c_int lua_type(lua_State* L, c_int idx);
	[CLink] public static extern char* lua_typename(lua_State* L, c_int tp);

	[CLink] public static extern c_int lua_equal(lua_State* L, c_int idx1, c_int idx2);
	[CLink] public static extern c_int lua_rawequal(lua_State* L, c_int idx1, c_int idx2);
	[CLink] public static extern c_int lua_lessthan(lua_State* L, c_int idx1, c_int idx2);

	[CLink] public static extern lua_Number lua_tonumber(lua_State* L, c_int idx);
	[CLink] public static extern lua_Integer lua_tointeger(lua_State* L, c_int idx);
	[CLink] public static extern c_int lua_toboolean(lua_State* L, c_int idx);
	[CLink] public static extern char* lua_tolstring(lua_State* L, c_int idx, size_t* len);
	[CLink] public static extern size_t lua_objlen(lua_State* L, c_int idx);
	[CLink] public static extern lua_CFunction lua_tocfunction(lua_State* L, c_int idx);
	[CLink] public static extern void* lua_touserdata(lua_State* L, c_int idx);
	[CLink] public static extern lua_State* lua_tothread(lua_State* L, c_int idx);
	[CLink] public static extern void* lua_topointer(lua_State* L, c_int idx);


	struct va_list;

	/*
	** push functions (C -> stack)
	*/
	[CLink] public static extern void lua_pushnil(lua_State* L);
	[CLink] public static extern void lua_pushnumber(lua_State* L, lua_Number n);
	[CLink] public static extern void lua_pushinteger(lua_State* L, lua_Integer n);
	[CLink] public static extern void lua_pushlstring(lua_State* L, char* s, size_t l);
	[CLink] public static extern void lua_pushstring(lua_State* L, char* s);
	[CLink] public static extern char* lua_pushvfstring(lua_State* L, char* fmt, va_list argp);
	[CLink] public static extern char* lua_pushfstring(lua_State* L, char* fmt, ...);
	[CLink] public static extern void lua_pushcclosure(lua_State* L, lua_CFunction fn, c_int n);
	[CLink] public static extern void lua_pushboolean(lua_State* L, c_int b);
	[CLink] public static extern void lua_pushlightuserdata(lua_State* L, void* p);
	[CLink] public static extern c_int lua_pushthread(lua_State* L);


	/*
	** get functions (Lua -> stack)
	*/
	[CLink] public static extern void lua_gettable(lua_State* L, c_int idx);
	[CLink] public static extern void lua_getfield(lua_State* L, c_int idx, char* k);
	[CLink] public static extern void lua_rawget(lua_State* L, c_int idx);
	[CLink] public static extern void lua_rawgeti(lua_State* L, c_int idx, c_int n);
	[CLink] public static extern void lua_createtable(lua_State* L, c_int narr, c_int nrec);
	[CLink] public static extern void* lua_newuserdata(lua_State* L, size_t sz);
	[CLink] public static extern c_int lua_getmetatable(lua_State* L, c_int objindex);
	[CLink] public static extern void lua_getfenv(lua_State* L, c_int idx);


	/*
	** set functions (stack -> Lua)
	*/
	[CLink] public static extern void lua_settable(lua_State* L, c_int idx);
	[CLink] public static extern void lua_setfield(lua_State* L, c_int idx, char* k);
	[CLink] public static extern void lua_rawset(lua_State* L, c_int idx);
	[CLink] public static extern void lua_rawseti(lua_State* L, c_int idx, c_int n);
	[CLink] public static extern c_int lua_setmetatable(lua_State* L, c_int objindex);
	[CLink] public static extern c_int lua_setfenv(lua_State* L, c_int idx);


	/*
	** `load' and `call' functions (load and run Lua code)
	*/
	[CLink] public static extern void lua_call(lua_State* L, c_int nargs, c_int nresults);
	[CLink] public static extern c_int lua_pcall(lua_State* L, c_int nargs, c_int nresults, c_int errfunc);
	[CLink] public static extern c_int lua_cpcall(lua_State* L, lua_CFunction func, void* ud);
	[CLink] public static extern c_int lua_load(lua_State* L, lua_Reader reader, void* dt, char* chunkname);

	[CLink] public static extern c_int lua_dump(lua_State* L, lua_Writer writer, void* data);


	/*
	** coroutine functions
	*/
	[CLink] public static extern c_int lua_yield(lua_State* L, c_int nresults);
	[CLink] public static extern c_int lua_resume(lua_State* L, c_int narg);
	[CLink] public static extern c_int lua_status(lua_State* L);

	/*
	** garbage-collection function and options
	*/

	public const c_int LUA_GCSTOP			= 0;
	public const c_int LUA_GCRESTART			= 1;
	public const c_int LUA_GCCOLLECT			= 2;
	public const c_int LUA_GCCOUNT			= 3;
	public const c_int LUA_GCCOUNTB			= 4;
	public const c_int LUA_GCSTEP			= 5;
	public const c_int LUA_GCSETPAUSE		= 6;
	public const c_int LUA_GCSETSTEPMUL		= 7;
	public const c_int LUA_GCISRUNNING		= 9;

	public function c_int lua_gc(lua_State* L, c_int what, c_int data);


	/*
	** miscellaneous functions
	*/

	public function c_int lua_error(lua_State* L);

	public function c_int lua_next(lua_State* L, c_int idx);

	public function void lua_concat(lua_State* L, c_int n);

	public function lua_Alloc lua_getallocf(lua_State* L, void** ud);

	[CLink] public static extern void lua_setallocf(lua_State* L, lua_Alloc f, void* ud);



	/*
	** ===============================================================
	** some useful macros
	** ===============================================================
	*/

	// #define lua_pop(L,n)		lua_settop(L, -(n)-1)

	// #define lua_newtable(L)		lua_createtable(L, 0, 0)

	// #define lua_register(L,n,f) (lua_pushcfunction(L, (f)), lua_setglobal(L, (n)))

	// #define lua_pushcfunction(L,f)	lua_pushcclosure(L, (f), 0)

	// #define lua_strlen(L,i)		lua_objlen(L, (i))

	// #define lua_isfunction(L,n)	(lua_type(L, (n)) == LUA_TFUNCTION)
	// #define lua_istable(L,n)	(lua_type(L, (n)) == LUA_TTABLE)
	// #define lua_islightuserdata(L,n)	(lua_type(L, (n)) == LUA_TLIGHTUSERDATA)
	// #define lua_isnil(L,n)		(lua_type(L, (n)) == LUA_TNIL)
	// #define lua_isboolean(L,n)	(lua_type(L, (n)) == LUA_TBOOLEAN)
	// #define lua_isthread(L,n)	(lua_type(L, (n)) == LUA_TTHREAD)
	// #define lua_isnone(L,n)		(lua_type(L, (n)) == LUA_TNONE)
	// #define lua_isnoneornil(L, n)	(lua_type(L, (n)) <= 0)

	// #define lua_pushliteral(L, s)	\
	// 	lua_pushlstring(L, "" s, (sizeof(s)/sizeof(char))-1)

	// #define lua_setglobal(L,s)	lua_setfield(L, LUA_GLOBALSINDEX, (s))
	// #define lua_getglobal(L,s)	lua_getfield(L, LUA_GLOBALSINDEX, (s))

	[Inline] public static char* lua_tostring(lua_State* L, c_int i)
	{
		return lua_tolstring(L, i, null);
	}

	/*
	** compatibility macros and functions
	*/

	// #define lua_open()	luaL_newstate()

	// #define lua_getregistry(L)	lua_pushvalue(L, LUA_REGISTRYINDEX)

	// #define lua_getgccount(L)	lua_gc(L, LUA_GCCOUNT, 0)

	// #define lua_Chunkreader		lua_Reader
	// #define lua_Chunkwriter		lua_Writer


	/* hack */
	[CLink] public static extern void lua_setlevel	(lua_State* from, lua_State* to);


	/*
	** {======================================================================
	** Debug API
	** =======================================================================
	*/


	/*
	** Event codes
	*/
	public const c_int LUA_HOOKCALL		= 0;
	public const c_int LUA_HOOKRET		= 1;
	public const c_int LUA_HOOKLINE		= 2;
	public const c_int LUA_HOOKCOUNT		= 3;
	public const c_int LUA_HOOKTAILRET 	= 4;


	/*
	** Event masks
	*/

	// c_int LUA_MASKCALL	(1 << LUA_HOOKCALL); c_int LUA_MASKRET	(1 << LUA_HOOKRET); c_int LUA_MASKLINE	(1 << LUA_HOOKLINE); c_int LUA_MASKCOUNT	(1 << LUA_HOOKCOUNT);

	/* Functions to be called by the debuger in specific events */
	public function void lua_Hook(lua_State* L, lua_Debug* ar);

	[CLink] public static extern c_int lua_getstack(lua_State* L, c_int level, lua_Debug* ar);
	[CLink] public static extern c_int lua_getinfo(lua_State* L, char* what, lua_Debug* ar);
	[CLink] public static extern char* lua_getlocal(lua_State* L, lua_Debug* ar, c_int n);
	[CLink] public static extern char* lua_setlocal(lua_State* L, lua_Debug* ar, c_int n);
	[CLink] public static extern char* lua_getupvalue(lua_State* L, c_int funcindex, c_int n);
	[CLink] public static extern char* lua_setupvalue(lua_State* L, c_int funcindex, c_int n);
	[CLink] public static extern c_int lua_sethook(lua_State* L, lua_Hook func, c_int mask, c_int count);
	[CLink] public static extern lua_Hook lua_gethook(lua_State* L);
	[CLink] public static extern c_int lua_gethookmask(lua_State* L);
	[CLink] public static extern c_int lua_gethookcount(lua_State* L);

	/* From Lua 5.2. */
	[CLink] public static extern void* lua_upvalueid(lua_State* L, c_int idx, c_int n);
	[CLink] public static extern void lua_upvaluejoin(lua_State* L, c_int idx1, c_int n1, c_int idx2, c_int n2);
	[CLink] public static extern c_int lua_loadx(lua_State* L, lua_Reader reader, void* dt, char* chunkname, char* mode);
	[CLink] public static extern lua_Number* lua_version(lua_State* L);
	[CLink] public static extern void lua_copy(lua_State* L, c_int fromidx, c_int toidx);
	[CLink] public static extern lua_Number lua_tonumberx(lua_State* L, c_int idx, c_int* isnum);
	[CLink] public static extern lua_Integer lua_tointegerx(lua_State* L, c_int idx, c_int* isnum);

	/* From Lua 5.3. */
	[CLink] public static extern c_int lua_isyieldable(lua_State* L);

	struct lua_Debug
	{
		c_int event;
		char* name; /* (n) */
		char* namewhat; /* (n) `global', `local', `field', `method' */
		char* what; /* (S) `Lua', `C', `main', `tail' */
		char* source; /* (S) */
		c_int currentline; /* (l) */
		c_int nups; /* (u) number of upvalues */
		c_int linedefined; /* (S) */
		c_int lastlinedefined; /* (S) */
		char short_src; /* (S) */
		/* private part */
		c_int i_ci; /* active function */
	}
}