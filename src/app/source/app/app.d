module app;

import soba.canvas;

import numem.all;
import inmath;

import std.stdio;

void main() {
    writeln(cnvInit());

    shared_ptr!SbCanvas canvas = SbCanvas.create(SbCanvasFormat.ARGB32, 124, 124);
    shared_ptr!SbContext ctx = SbContext.create(canvas);

    ctx.roundRect(rect(26, 42, 82, 60), 8);
    ctx.setSource(vec4(0, (0x80 + 0.0f)/0xFF, 0, 1));
    ctx.fillPreserve();
    ctx.setSource(vec4(0, (0x80 + 0.0f)/0xFF, 0, 1));
    ctx.stroke();

    ctx.roundRect(rect(47, 56, 7, 26), 3);
    ctx.setSource(vec4(0, 0, 0, 1));
    ctx.fillPreserve();
    ctx.setSource(vec4(0, 0, 0, 1));
    ctx.stroke();

    ctx.roundRect(rect(65, 56, 7, 26), 3);
    ctx.setSource(vec4(0, 0, 0, 1));
    ctx.fillPreserve();
    ctx.setSource(vec4(0, 0, 0, 1));
    ctx.stroke();

    ctx.roundRect(rect(30, 79, 11, 4), 3);
    ctx.setSource(vec4(0, 0, 0, 1));
    ctx.fillPreserve();
    ctx.setSource(vec4(0, 0, 0, 1));
    ctx.stroke();

    ctx.roundRect(rect(77, 79, 11, 4), 3);
    ctx.setSource(vec4(0, 0, 0, 1));
    ctx.fillPreserve();
    ctx.setSource(vec4(0, 0, 0, 1));
    ctx.stroke();

    ctx.roundRect(rect(47, 16, 6, 29), 3);
    ctx.setSource(vec4(0, (0x80 + 0.0f)/0xFF, 0, 1));
    ctx.fillPreserve();
    ctx.setSource(vec4(0, (0x80 + 0.0f)/0xFF, 0, 1));
    ctx.stroke();

    ctx.roundRect(rect(77, 16, 6, 29), 3);
    ctx.setSource(vec4(0, (0x80 + 0.0f)/0xFF, 0, 1));
    ctx.fillPreserve();
    ctx.setSource(vec4(0, (0x80 + 0.0f)/0xFF, 0, 1));
    ctx.stroke();

    ctx.roundRect(rect(32, 16, 21, 8), 3);
    ctx.setSource(vec4(0, (0x80 + 0.0f)/0xFF, 0, 1));
    ctx.fillPreserve();
    ctx.setSource(vec4(0, (0x80 + 0.0f)/0xFF, 0, 1));
    ctx.stroke();

    ctx.roundRect(rect(62, 16, 21, 8), 3);
    ctx.setSource(vec4(0, (0x80 + 0.0f)/0xFF, 0, 1));
    ctx.fillPreserve();
    ctx.setSource(vec4(0, (0x80 + 0.0f)/0xFF, 0, 1));
    ctx.stroke();

    canvas.writeToFile(nstring("test.png"));
}
