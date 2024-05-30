module app;
import soba;
import soba.core.gpu;
import soba.ui.window.appwindow;
import soba.drawing;

class MyApplication : SbApplicationWindow {
public:
    this(SbApp app) {
        super(app, 640, 480);
    }

    /**
        Called when the application should be re-rendered.
    */
    override
    void onRender(SbDrawingContext drawing) {
        // TODO: draw stuff
    }
}

int main() {
    sbInit();

    SbAppInfo info;
    info.name = nstring("My Cool App");
    info.version_ = nstring("1.0.0");

    SbApplication app = nogc_new!SbApplication(info);
    return app.run(nogc_new!MyApplication(app, 640, 480));
}