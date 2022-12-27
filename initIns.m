function ins = initIns(avp0, ts)

global glv
    avp0 = avp0(:);
    [qnb0, vn0, pos0] = setvals(a2qua(avp0(1:3)), avp0(4:6), avp0(7:9));      
	ins = [];
	ins.ts = ts; ins.nts = 2*ts;
    [ins.qnb, ins.vn, ins.pos] = setvals(qnb0, vn0, pos0); 
    ins.vn0 = vn0; ins.pos0 = pos0;
	[ins.qnb, ins.att, ins.Cnb] = attsyn(ins.qnb);  ins.Cnb0 = ins.Cnb;
    ins.avp  = [ins.att; ins.vn; ins.pos];
    ins.eth = ethInit(ins.pos, ins.vn);
    ins.Mpv = [ 1/ins.eth.RMh, 0,0; 0, 1/ins.eth.clRNh, 0; 0, 0, -1];
    glv.wm_1 = zeros(3,1)';  glv.vm_1 = zeros(3,1)';  % 方便圆锥补偿和划桨补偿，它俩对应的是上一时刻的速度和角度增量
    ins.an = zeros(3,1); %上一个时刻的加速度
