::ִ�з�����ʹ�� make.bat ����
::[����1]��ThirdPart·��
::[����2]��GLDRS·��
::[����3]���汾
::[����4]��ThirdPart��Ŀ¼
::[����5]�����ɵİ汾·��
::���磺ThirdPart_Conan_Linux_aarch64.bat D:\GLD\gcr\ThirdPart C:\Users\chongkx\.conan\data boost/1.52.0 boost boost\1.52.0
::λ�ã��û�/xxx/.conan


@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

SET ThirdPart=%1
SET GLDRS=%2
SET Version_number=%3
SET NAME=%4
SET NAME_V=%5

SET d=%GLDRS%\%NAME_V%

echo=
echo                          %NAME%ģ��
echo=
echo=======������½�ģ��=========
rd /s %GLDRS%\%NAME%
md %GLDRS%\%NAME_V%
xcopy %ThirdPart%\%NAME% %d% /s /e /y

echo======����conan��=========
cd %d%
conan new %Version_number% --bare

echo======����ļ�==========
conan export-pkg . %Version_number%@CBB/Original  -s  os=Linux -s os_build=Linux -s arch=armv8 -s arch_build=armv8 -s compiler=gcc -s compiler.version=5.4 -s build_type=Release -s compiler.libcxx=libstdc++ --force

echo======ɸѡ������CBB���ļ���ɾ��======
dir . /ad /b |findstr /i /v "CBB" > %GLDRS%\fold.txt
dir . /a-d /b |findstr /i /v "CBB" > %GLDRS%\folders.txt
for /f "delims=" %%k in (%GLDRS%\fold.txt) do rd /q /s %d%\%%k
for /f "delims=" %%j in (%GLDRS%\folders.txt) do del /q %d%\%%j

echo======�ϴ���==================
conan upload %Version_number%@CBB/Original -r CBB-ThirdPart --all

cd /d %~dp0








