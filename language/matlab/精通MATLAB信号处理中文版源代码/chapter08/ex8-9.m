clear all;
lshaar = liftwave('haar');
els = {'p',[-0.25 0.25],0};
lsnew = addlift(lshaar,els);
x = 1:16;
[cA,cD] = lwt(x,lsnew)
lshaarInt = liftwave('haar','int2int');
lsnewInt = addlift(lshaarInt,els);
[cAint,cDint] = lwt(x,lsnewInt)
