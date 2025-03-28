/*
** Standard library header.
** Copyright (C) 2005-2025 Mike Pall. See Copyright Notice in luajit.h
*/

using System;

namespace luajit_Beef;

extension luajit
{
	public const char* LUA_FILEHANDLE			= "FILE*";

	public const char* LUA_COLIBNAME			= "coroutine";
	public const char* LUA_MATHLIBNAME			= "math";
	public const char* LUA_STRLIBNAME			= "string";
	public const char* LUA_TABLIBNAME			= "table";
	public const char* LUA_IOLIBNAME			= "io";
	public const char* LUA_OSLIBNAME			= "os";
	public const char* LUA_LOADLIBNAME			= "package";
	public const char* LUA_DBLIBNAME			= "debug";
	public const char* LUA_BITLIBNAME			= "bit";
	public const char* LUA_JITLIBNAME			= "jit";
	public const char* LUA_FFILIBNAME			= "ffi";

	[CLink] public static extern int luaopen_base(lua_State* L);
	[CLink] public static extern int luaopen_math(lua_State* L);
	[CLink] public static extern int luaopen_string(lua_State* L);
	[CLink] public static extern int luaopen_table(lua_State* L);
	[CLink] public static extern int luaopen_io(lua_State* L);
	[CLink] public static extern int luaopen_os(lua_State* L);
	[CLink] public static extern int luaopen_package(lua_State* L);
	[CLink] public static extern int luaopen_debug(lua_State* L);
	[CLink] public static extern int luaopen_bit(lua_State* L);
	[CLink] public static extern int luaopen_jit(lua_State* L);
	[CLink] public static extern int luaopen_ffi(lua_State* L);
	[CLink] public static extern int luaopen_string_buffer(lua_State* L);

	[CLink] public static extern void luaL_openlibs(lua_State* L);
}