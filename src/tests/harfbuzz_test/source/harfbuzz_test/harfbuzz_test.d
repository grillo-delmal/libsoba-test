module harfbuzz_test;
import harfbuzz;
import std.stdio;

int main() {
    // 0. Load Harfbuzz
    writeln("0");

    auto result = loadHarfBuzz();
    writeln(result);

    // 1. Create a buffer and put your text in it. 
    writeln("1");

    hb_buffer_t *buf;
    writeln("1.1");
    buf = hb_buffer_create();
    writeln("1.2");
    hb_buffer_add_utf8(buf, "poto", -1, 0, -1);


    // 2. Set the script, language and direction of the buffer. 
    writeln("2");

    // If you know the direction, script, and language
    hb_buffer_set_direction(buf, hb_direction_t.HB_DIRECTION_LTR);
    hb_buffer_set_script(buf, hb_script_t.HB_SCRIPT_LATIN);
    hb_buffer_set_language(buf, hb_language_from_string("en", -1));

    // If you don't know the direction, script, and language
    hb_buffer_guess_segment_properties(buf);
    

    // 3. Create a face and a font from a font file. 
    writeln("3");

    hb_blob_t *blob = hb_blob_create_from_file("noto.ttf"); /* or hb_blob_create_from_file_or_fail() */
    hb_face_t *face = hb_face_create(blob, 0);
    hb_font_t *font = hb_font_create(face);

    // 4. Shape! 
    writeln("4");

    hb_shape(font, buf, null, 0);
    

    // 5. Get the glyph and position information. 
    writeln("5");

    uint glyph_count;
    hb_glyph_info_t *glyph_info    = hb_buffer_get_glyph_infos(buf, &glyph_count);
    hb_glyph_position_t *glyph_pos = hb_buffer_get_glyph_positions(buf, &glyph_count);
    
    // 6. Iterate over each glyph. 
    writeln("6");

    hb_position_t cursor_x = 0;
    hb_position_t cursor_y = 0;
    for (uint i = 0; i < glyph_count; i++) {
        hb_codepoint_t glyphid  = glyph_info[i].codepoint;
        hb_position_t x_offset  = glyph_pos[i].x_offset;
        hb_position_t y_offset  = glyph_pos[i].y_offset;
        hb_position_t x_advance = glyph_pos[i].x_advance;
        hb_position_t y_advance = glyph_pos[i].y_advance;
    /* draw_glyph(glyphid, cursor_x + x_offset, cursor_y + y_offset); */
        cursor_x += x_advance;
        cursor_y += y_advance;
    }
    writeln("6.1 ", cursor_x, " ", cursor_y);

    // 7. Tidy up. 
    writeln("7");

    hb_buffer_destroy(buf);
    hb_font_destroy(font);
    hb_face_destroy(face);
    hb_blob_destroy(blob);
    
    return 0;
}