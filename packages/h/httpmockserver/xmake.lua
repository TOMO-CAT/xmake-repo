package("httpmockserver", function()
    set_homepage("https://github.com/seznam/httpmockserver")
    set_urls(
        "https://github.com/seznam/httpmockserver/archive/38d4425470aaed56a9d2a4c736500d405e74d2e1.tar.gz")
    add_versions("1.0.0",
                 "21b220a907a434e286ecb784dbb118f4a9c4cf2ee3303ec2718d6b1470cc5aa4")
    add_deps("microhttpd")
    on_install(function(package)
        io.writefile("xmake.lua", [[
            add_rules("mode.debug", "mode.release")
            set_languages("c++17")
            add_requires("microhttpd")
            target("httpmockserver", function()
                add_includedirs("include")
                add_headerfiles("include/(**.h)")
                set_kind("static")
                add_files("src/**.cc")
                add_packages("microhttpd") 
            end)
        ]])
        import("package.tools.xmake").install(package)
    end)
    on_test(function(package)
        assert(package:has_cxxtypes("httpmock::MockServer", {includes = "httpmockserver/mock_server.h"}))
    end)
end)
