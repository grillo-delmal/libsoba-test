module app;

import soba.canvas;

import numem.all;
import inmath;

import std.stdio;

void main() {
    writeln(cnvInit());

    shared_ptr!SbCanvas canvas = SbCanvas.create(SbCanvasFormat.ARGB32, 512, 512);
    shared_ptr!SbContext ctx = SbContext.create(canvas);

    ctx.roundRect(rect(64,64,128,128),32);
    ctx.setSource(vec4(1, 1, 1, 1));
    ctx.fillPreserve();
    ctx.setSource(vec4(0, 0, 0, 1));
    ctx.stroke();

    canvas.writeToFile(nstring("test.png"));
}
