module farfadet.gui.tabs;

import std.path;
import atelier;
import farfadet.common;

final private class TabButtonGui: GuiElement {
    private {
        Label _label;
        TabData _tabData;
    }

    this(TabData tabData) {
        _tabData = tabData;
        _label = new Label("untitled");
        _label.setAlign(GuiAlignX.Center, GuiAlignY.Center);
        addChildGui(_label);

        size(Vec2f(_label.size.x + 20f, 35f));
    }

    override void update(float deltaTime) {
        isSelected = getCurrentTab() == _tabData;
        if(isSelected) {
            if(_tabData.isTitleDirty) {
                _label.text = _tabData.title;
                size(Vec2f(_label.size.x + 20f, 35f));
            }
        }
    }

    override void onSubmit() {
        if(!isSelected) {
            setCurrentTab(_tabData);
            triggerCallback();
        }
    }

    override void draw() {
        drawFilledRect(origin, size, Color(.12f, .13f, .19f));
        if(isHovered)
            drawFilledRect(origin, size, Color(.2f, .2f, .2f));
        if(isClicked)
            drawFilledRect(origin, size, Color(.5f, .5f, .5f));
        if(isSelected)
            drawFilledRect(origin, size, Color(.4f, .4f, .5f));
    }
}

final class TabsGui: HContainer {
    this() {
        
    }

    override void draw() {
        drawFilledRect(origin, size, Color(.11f, .09f, .18f));
    }

    override void onCallback(string id) {
        if(id == "tab") {
            triggerCallback();
        }
    }

    void addTab() {
        if(!hasTab())
            return;
        auto tabData = getCurrentTab();
        auto tabGui = new TabButtonGui(tabData);
        tabGui.setCallback(this, "tab");
        addChildGui(tabGui);
    }
}