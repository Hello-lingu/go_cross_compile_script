-- 设置Go项目路径
local project_dir = os.getenv("PWD") or "."
-- 设置要支持的操作系统和架构
local os_list = {"linux", "darwin", "windows"}
local arch_list = {"amd64", "arm64", "386"}

-- 你的程序名字
local program_name = "word_dict"

-- 编译的输出目录
local output_dir = project_dir .. "/compiled"

-- 创建输出目录（如果不存在）
os.execute("mkdir -p " .. output_dir)

-- 循环遍历操作系统和架构
for _, os in ipairs(os_list) do
    for _, arch in ipairs(arch_list) do
        -- 设置GOOS和GOARCH
        print("正在为 " .. os .. "/" .. arch .. " 编译...")

        -- 设置GO环境变量并调用go build进行编译
        local cmd = string.format("GOOS=%s GOARCH=%s go build -o %s/%s_%s_%s .", os, arch, output_dir, program_name, os, arch)
        local handle = io.popen(cmd .. " 2>&1")
        local output = handle:read("*a")
        local success, _, exit_code = handle:close()

        if success and exit_code == 0 then
            print("成功编译 " .. os .. "/" .. arch)
        else
            print("编译 " .. os .. "/" .. arch .. " 失败")
            print("错误信息: " .. output)
        end
    end
end

print("所有编译完成!")
