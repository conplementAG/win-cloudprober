# escape=`
FROM mcr.microsoft.com/windows/servercore:ltsc2019
SHELL ["powershell"]
WORKDIR c:\tools

ARG CLOUDPROBERVERSION=v0.11.9

RUN wget https://github.com/cloudprober/cloudprober/releases/download/${ENV:CLOUDPROBERVERSION}/cloudprober-${ENV:CLOUDPROBERVERSION}-windows-x86_64.zip -outfile "c:\tools\cloudprober.zip"; `
    Expand-Archive -Path c:\tools\cloudprober.zip -DestinationPath c:\tools\cloudprober; `
    Move-Item -Path c:\tools\cloudprober\cloudprober-${ENV:CLOUDPROBERVERSION}-windows-x86_64\cloudprober.exe -Destination c:\tools\cloudprober.exe; `
    Remove-Item -Path c:\tools\cloudprober.zip –Recurse; `
    Remove-Item -Path c:\tools\cloudprober -Force -Recurse;

ENTRYPOINT ["c:\tools\cloudprober.exe", "--logtostderr"]