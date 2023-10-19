#!/bin/sh

PDFM_DIR="/Applications/Parallels Desktop.app"
PDFM_DISP_DST="${PDFM_DIR}/Contents/MacOS/Parallels Service.app/Contents/MacOS/prl_disp_service"
PDFM_DISP_PATCH="${PDFM_DISP_DST}_patched"
PDFM_DISP_BCUP="${PDFM_DISP_DST}_backup"

if [ "$(pgrep -x prl_disp_service)" != "" ] && [ "$(pgrep -x prl_client_app)" != "" ]; then
    open "${PDFM_DIR}"
    exit 0
fi

sudo cp -f "${PDFM_DISP_PATCH}" "${PDFM_DISP_DST}"
open "${PDFM_DIR}"

sleep 2


sudo cp -f "${PDFM_DISP_BCUP}" "${PDFM_DISP_DST}"
