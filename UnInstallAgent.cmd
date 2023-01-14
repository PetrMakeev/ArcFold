echo off


schtasks /delete /tn ArcFoldAgentStartUp /F
schtasks /delete /tn ArcFoldAgentCheck /F
schtasks /delete /tn ArcFoldServiceStartUp /F
schtasks /delete /tn ArcFoldServiceCheck /F

Echo Служба удалена из планировщика задач

GOTO EOF



:EOF

