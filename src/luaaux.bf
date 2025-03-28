/*
** $Id: lauxlib.h,v 1.88.1.1 2007/12/27 13:02:25 roberto Exp $
** Auxiliary functions for building Lua libraries
** See Copyright Notice in lua.h
*/

using System;

namespace luajit_Beef;

extension luajit
{
	/* extra error code for `luaL_load' */
	// #define LUA_ERRFILE     (LUA_ERRERR+1)

	[CRepr]
	public struct luaL_Reg
	{
		public char* name;
		public lua_CFunction func;
	}

	[CLink] public static extern void luaL_openlib(lua_State* L, char* libname, luaL_Reg* l, int nup);
	[CLink] public static extern void luaL_register(lua_State* L, char* libname, luaL_Reg* l);
	[CLink] public static extern int luaL_getmetafield(lua_State* L, int obj, char* e);
	[CLink] public static extern int luaL_callmeta(lua_State* L, int obj, char* e);
	[CLink] public static extern int luaL_typerror(lua_State* L, int narg, char* tname);
	[CLink] public static extern int luaL_argerror(lua_State* L, int numarg, char* extramsg);
	[CLink] public static extern char* luaL_checklstring(lua_State* L, int numArg, size_t* l);
	[CLink] public static extern char* luaL_optlstring(lua_State* L, int numArg, char* def, size_t* l);
	[CLink] public static extern lua_Number luaL_checknumber(lua_State* L, int numArg);
	[CLink] public static extern lua_Number luaL_optnumber(lua_State* L, int nArg, lua_Number def);

	[CLink] public static extern lua_Integer luaL_checkinteger(lua_State* L, int numArg);
	[CLink] public static extern lua_Integer luaL_optinteger(lua_State* L, int nArg, lua_Integer def);

	[CLink] public static extern void luaL_checkstack(lua_State* L, int sz, char* msg);
	[CLink] public static extern void luaL_checktype(lua_State* L, int narg, int t);
	[CLink] public static extern void luaL_checkany(lua_State* L, int narg);

	[CLink] public static extern int luaL_newmetatable(lua_State* L, char* tname);
	[CLink] public static extern void* luaL_checkudata(lua_State* L, int ud, char* tname);

	[CLink] public static extern void luaL_where(lua_State* L, int lvl);
	[CLink] public static extern int luaL_error(lua_State* L, char* fmt, ...);

	[CLink] public static extern int luaL_checkoption(lua_State* L, int narg, char* def, char[]* lst);

	/* pre-defined references */
	public const int LUA_NOREF       = (-2);
	public const int LUA_REFNIL      = (-1);

	[CLink] public static extern int luaL_ref(lua_State* L, int t);
	[CLink] public static extern void luaL_unref(lua_State* L, int t, int reference);

	[CLink] public static extern int luaL_loadfile(lua_State* L, char* filename);
	[CLink] public static extern int luaL_loadbuffer(lua_State* L, char* buff, size_t sz, char* name);
	[CLink] public static extern int luaL_loadstring(lua_State* L, char* s);

	[CLink] public static extern lua_State* luaL_newstate();

	[CLink] public static extern char* luaL_gsub(lua_State* L, char* s, char* p, char* r);

	[CLink] public static extern char* luaL_findtable(lua_State* L, int idx, char* fname, int szhint);

	/* From Lua 5.2. */
	[CLink] public static extern int luaL_fileresult(lua_State* L, int stat, char* fname);
	[CLink] public static extern int luaL_execresult(lua_State* L, int stat);
	[CLink] public static extern int luaL_loadfilex(lua_State* L, char* filename, char* mode);
	[CLink] public static extern int luaL_loadbufferx(lua_State* L, char* buff, size_t sz, char* name, char* mode);
	[CLink] public static extern void luaL_traceback(lua_State* L, lua_State* L1, char* msg, int level);
	[CLink] public static extern void luaL_setfuncs(lua_State* L, luaL_Reg* l, int nup);
	[CLink] public static extern void luaL_pushmodule(lua_State* L, char* modname, int sizehint);
	[CLink] public static extern void* luaL_testudata(lua_State* L, int ud, char* tname);
	[CLink] public static extern void luaL_setmetatable(lua_State* L, char* tname);


	/*
	** ===============================================================
	** some useful macros
	** ===============================================================
	*/

	// #define luaL_argcheck(L, cond,numarg,extramsg) ((void)((cond) || luaL_argerror(L, (numarg), (extramsg))))
	// #define luaL_checkstring(L,n) (luaL_checklstring(L, (n), NULL))
	// #define luaL_optstring(L,n,d) (luaL_optlstring(L, (n), (d), NULL))
	// #define luaL_checkint(L,n) ((int)luaL_checkinteger(L, (n)))
	// #define luaL_optint(L,n,d) ((int)luaL_optinteger(L, (n), (d)))
	// #define luaL_checklong(L,n)	((long)luaL_checkinteger(L, (n)))
	// #define luaL_optlong(L,n,d)	((long)luaL_optinteger(L, (n), (d)))

	// #define luaL_typename(L,i)	lua_typename(L, lua_type(L,(i)))

	// #define luaL_dofile(L, fn) \
	//     (luaL_loadfile(L, fn) || lua_pcall(L, 0, LUA_MULTRET, 0))

	// #define luaL_dostring(L, s) \
	//     (luaL_loadstring(L, s) || lua_pcall(L, 0, LUA_MULTRET, 0))

	// #define luaL_getmetatable(L,n)	(lua_getfield(L, LUA_REGISTRYINDEX, (n)))

	// #define luaL_opt(L,f,n,d)	(lua_isnoneornil(L,(n)) ? (d) : f(L,(n)))

	// /* From Lua 5.2. */
	// #define luaL_newlibtable(L, l) \
	//     lua_createtable(L, 0, sizeof(l)/sizeof((l)[0]) - 1)
	// #define luaL_newlib(L, l)	(luaL_newlibtable(L, l), luaL_setfuncs(L, l, 0))

	/*
	** {======================================================
	** Generic Buffer manipulation
	** =======================================================
	*/

	[CRepr] public struct luaL_Buffer
	{
		char* p; /* current position in buffer */
		int lvl; /* number of strings in the stack (level) */
		lua_State* L;
		char[LUAL_BUFFERSIZE] buffer;
	}

	// #define luaL_addchar(B,c) \
	// ((void)((B)->p < ((B)->buffer+LUAL_BUFFERSIZE) || luaL_prepbuffer(B)), \
	// (*(B)->p++ = (char)(c)))

	/* compatibility only */
	// #define luaL_putchar(B,c)	luaL_addchar(B,c)

	// #define luaL_addsize(B,n)	((B)->p += (n))

	[CLink] public static extern void luaL_buffinit(lua_State* L, luaL_Buffer* B);
	[CLink] public static extern char* luaL_prepbuffer(luaL_Buffer* B);
	[CLink] public static extern void luaL_addlstring(luaL_Buffer* B, char* s, size_t l);
	[CLink] public static extern void luaL_addstring(luaL_Buffer* B, char* s);
	[CLink] public static extern void luaL_addvalue(luaL_Buffer* B);
	[CLink] public static extern void luaL_pushresult(luaL_Buffer* B);
}