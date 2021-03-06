package mapviewer;

import mapviewer.logging.Logger;
import mapviewer.model.Model;
import mapviewer.renderer.webgl.WebGLRenderer;
import mapviewer.renderer.webgl.WebGLWorld;
import mapviewer.world.World;
import mapviewer.network.Connection;
import mapviewer.renderer.Renderer;
import js.html.CanvasElement;
import mapviewer.renderer.TextureInfo;
import Reflect;
import haxe.Json;
import mapviewer.block.BlockRegistry;
import js.html.XMLHttpRequest;
import js.Browser;
import js.html.ImageElement;

class Main {

    public static var blockTexturesRaw : Array<ImageElement> = new Array();
    public static var blockTextureInfo : Map<String, TextureInfo> = new Map();
    private static var loadedCount : Int = 0;
    private static var req1 : XMLHttpRequest;
    private static var req2 : XMLHttpRequest;
    private static var canvas : CanvasElement;
    public static var renderer : Renderer;
    public static var connection : Connection;
    public static var world : World;
	public static var modelData : Dynamic;
	public static var textureData : Dynamic;

    static function main() {
        var img = Browser.document.createImageElement();
        img.onload = ready;
        img.src = "block_images/blocks_0.png";
        req1 = new XMLHttpRequest();
        req1.onload = ready;
        req1.open("GET", "block_images/blocks.json", true);
        req1.send();
        req2 = new XMLHttpRequest();
        req2.onload = ready;
        req2.open("GET", "block_models/models.json", true);
        req2.send();
		blockTexturesRaw.push(img);
    }

    static function ready(event : Dynamic) {
        loadedCount++;
        if (loadedCount != 3) {
            return;
        }

        var js = Json.parse(req1.response);
		textureData = js;
        for (e in Reflect.fields(js)) {
            var ti = Reflect.field(js, e);
            blockTextureInfo[e] = new TextureInfo(ti.start, ti.end);
        }
		
        var mJs = Json.parse(req2.responseText);
		modelData = mJs;
		for (k in Reflect.fields(mJs)) {
			var model = new Model();
			model.fromMap(Reflect.field(mJs, k));
			Model.models[k] = model;
		}
        BlockRegistry.init();

        canvas = cast Browser.document.getElementById("main");
        canvas.width = Browser.window.innerWidth;
        canvas.height = Browser.window.innerHeight;
        Browser.window.onresize = function(e) {
            canvas.width = Browser.window.innerWidth;
            canvas.height = Browser.window.innerHeight;
			renderer.resize(canvas.width, canvas.height);
        };

        connection = new Connection('${Config.hostname}:${Config.port}');
		
		world = new WebGLWorld();
		renderer = new WebGLRenderer(canvas);
        Browser.window.requestAnimationFrame(draw);
    }

    private static function draw(unused : Float) : Bool {
		renderer.draw();
        Browser.window.requestAnimationFrame(draw);
        return true;
    }
	
	static function __init__() {
		Logger.CAN_LOG = true;
	}
}