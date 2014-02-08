package think.webglmap.bukkit.web;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.ByteBufOutputStream;
import io.netty.buffer.Unpooled;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelFutureListener;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.SimpleChannelInboundHandler;
import io.netty.handler.codec.http.DefaultFullHttpResponse;
import io.netty.handler.codec.http.FullHttpRequest;
import io.netty.handler.codec.http.FullHttpResponse;
import io.netty.handler.codec.http.websocketx.*;
import io.netty.util.CharsetUtil;
import lombok.RequiredArgsConstructor;
import org.apache.commons.io.IOUtils;
import org.bukkit.Bukkit;
import think.webglmap.bukkit.WebglMapPlugin;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.logging.Logger;

import static io.netty.handler.codec.http.HttpHeaders.Names.CONTENT_TYPE;
import static io.netty.handler.codec.http.HttpHeaders.Names.HOST;
import static io.netty.handler.codec.http.HttpHeaders.isKeepAlive;
import static io.netty.handler.codec.http.HttpHeaders.setContentLength;
import static io.netty.handler.codec.http.HttpMethod.GET;
import static io.netty.handler.codec.http.HttpResponseStatus.*;
import static io.netty.handler.codec.http.HttpVersion.HTTP_1_1;

@RequiredArgsConstructor
public class WebSocketHandler extends SimpleChannelInboundHandler<BinaryWebSocketFrame> {

    private final static Logger logger = Logger.getLogger(WebSocketHandler.class.getName());

    private final WebglMapPlugin plugin;
    private final int id;

    @Override
    protected void channelRead0(ChannelHandlerContext ctx, BinaryWebSocketFrame msg) throws Exception {
        ByteBuf data = msg.content();
        switch (data.readUnsignedByte()) {
//            case 0: //Chunk request
//                ByteBuf out = Unpooled.buffer();
//                out.writeByte(1);
//                if (plugin.getChunkManager(plugin.targetWorld).getChunkBytes(data.readInt(), data.readInt(), out)) {
//                    ctx.writeAndFlush(new BinaryWebSocketFrame(out));
//                }
//                break;
        }
        data.release();
    }
}