# escape=`
FROM mcr.microsoft.com/windows/servercore:ltsc2019
SHELL ["powershell"]
WORKDIR c:\tools

ARG CLOUDPROBERVERSION=v0.11.9

RUN wget https://github.com/cloudprober/cloudprober/releases/download/${ENV:CLOUDPROBERVERSION}/cloudprober-${ENV:CLOUDPROBERVERSION}-windows-x86_64.zip -outfile "c:\tools\cloudprober.zip"; `
    ls c:\tools; 

RUN Expand-Archive -Path c:\tools\cloudprober.zip -DestinationPath c:/tools/cloudprober; `
    Remove-Item -Path c:\tools\cloudprober.zip –Recurse; `
    ls c:\tools\cloudprober; 

ENTRYPOINT ["c:\tools\cloudprober\cloudprober-${ENV:CLOUDPROBERVERSION}-windows-x86_64.exe", "--logtostderr"]