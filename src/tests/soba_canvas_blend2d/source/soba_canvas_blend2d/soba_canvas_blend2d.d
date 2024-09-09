module soba_canvas_cairo;

import soba.canvas;

import numem.all;
import inmath;

import std.stdio;

void main() {
    cnvInit();

    SbImage image = new SbImage(124, 124, SbImageFormat.RGBA32);
    SbContext ctx = SbContext.create();

    ctx.begin(image);

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

    ctx.end();

    image.writeToFile(nstring("test.png"));
}
