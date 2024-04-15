# escape=`
FROM mcr.microsoft.com/windows/servercore:ltsc2022 AS servercore
SHELL ["powershell"]
WORKDIR c:\tools

ARG CLOUDPROBERVERSION=v0.13.3

RUN wget https://github.com/cloudprober/cloudprober/releases/download/${ENV:CLOUDPROBERVERSION}/cloudprober-${ENV:CLOUDPROBERVERSION}-windows-x86_64.zip -outfile "c:\tools\cloudprober.zip"; `
    Expand-Archive -Path c:\tools\cloudprober.zip -DestinationPath c:\tools\cloudprober; `
    Move-Item -Path c:\tools\cloudprober\cloudprober-${ENV:CLOUDPROBERVERSION}-windows-x86_64\cloudprober.exe -Destination c:\tools\cloudprober.exe; `
    Remove-Item -Path c:\tools\cloudprober.zip –Recurse; `
    Remove-Item -Path c:\tools\cloudprober -Force -Recurse;


FROM mcr.microsoft.com/windows/nanoserver:ltsc2022

COPY --from=servercore /tools /tools

ENTRYPOINT ["c:\tools\cloudprober", "--logtostderr"]