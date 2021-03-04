::执行方法：使用 make.bat 调用
::[参数1]：ThirdPart路径
::[参数2]：GLDRS路径
::[参数3]：版本
::[参数4]：ThirdPart的目录
::[参数5]：生成的版本路径
::例如：ThirdPart_Conan_Linux_aarch64.bat D:\GLD\gcr\ThirdPart C:\Users\chongkx\.conan\data boost/1.52.0 boost boost\1.52.0
::位置：用户/xxx/.conan


@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

SET ThirdPart=%1
SET GLDRS=%2
SET Version_number=%3
SET NAME=%4
SET NAME_V=%5

SET d=%GLDRS%\%NAME_V%

echo=
echo                          %NAME%模块
echo=
echo=======清除并新建模块=========
rd /s %GLDRS%\%NAME%
md %GLDRS%\%NAME_V%
xcopy %ThirdPart%\%NAME% %d% /s /e /y

echo======创建conan包=========
cd %d%
conan new %Version_number% --bare

echo======打包文件==========
conan export-pkg . %Version_number%@CBB/Original  -s  os=Linux -s os_build=Linux -s arch=armv8 -s arch_build=armv8 -s compiler=gcc -s compiler.version=5.4 -s build_type=Release -s compiler.libcxx=libstdc++ --force

echo======筛选出不是CBB的文件并删除======
dir . /ad /b |findstr /i /v "CBB" > %GLDRS%\fold.txt
dir . /a-d /b |findstr /i /v "CBB" > %GLDRS%\folders.txt
for /f "delims=" %%k in (%GLDRS%\fold.txt) do rd /q /s %d%\%%k
for /f "delims=" %%j in (%GLDRS%\folders.txt) do del /q %d%\%%j

echo======上传库==================
conan upload %Version_number%@CBB/Original -r CBB-ThirdPart --all

cd /d %~dp0








