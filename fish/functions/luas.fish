function luas
    luastatic $argv[1] (brew --prefix lua)/lib/liblua.a -I(brew --prefix lua)/include/lua
end
