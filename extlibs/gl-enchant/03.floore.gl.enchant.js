/**
 * phi
 */

if (enchant.gl) {
    
    (function(){
        
        var DEFAULT_PARAM = {
            width       : 100,
            height      : 100,
            widthDivit  : 17,
            heightDivit : 17,
            color0      : [
                1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0
            ],
            color1      : [
                0.0, 1.0, 1.0, 1.0,
                0.0, 1.0, 1.0, 1.0,
                0.0, 1.0, 1.0, 1.0,
                0.0, 1.0, 1.0, 1.0
            ],
        };
        
        var ARG_NAME_LIST = [
            "width",
            "height",
            "widthDivit",
            "heightDivit",
            "color0",
            "color1",
        ];
        
        enchant.gl.Floor = enchant.Class.create(enchant.gl.Sprite3D, {
            
            initialize: function(width, height, width_divit, height_divit, color0, color1) {
                enchant.gl.Sprite3D.call(this);
                
                var param = {};
                // オブジェクト引数対応
                if (typeof arguments[0] == "object") {
                    for (var key in arguments[0]) param[key] = arguments[0][key];
                }
                // 複数引数対応
                else {
                    for (var i=0,len=arguments.length; i<len; ++i) {
                        param[ ARG_NAME_LIST[i] ] = arguments[i];
                    }
                }
                
                // デフォルト値の代入
                for (var key in DEFAULT_PARAM) {
                    if (param[key] === undefined) {
                        param[key] = DEFAULT_PARAM[key];
                    }
                }
                
                // カラーが文字列だった場合は Floor.COLOR の対応する値に入れ替える
                if (typeof param.color0 == "string") param.color0 = enchant.gl.Floor.COLOR[ param.color0 ];
                if (typeof param.color1 == "string") param.color1 = enchant.gl.Floor.COLOR[ param.color1 ];
                
                width       = param.width;
                height      = param.height;
                width_divit = param.widthDivit;
                height_divit= param.heightDivit;
                colors0     = param.color0;
                colors1     = param.color1;
                
                var piece_width         = param.width   / param.widthDivit;
                var piece_height        = param.height  / param.heightDivit;
                var piece_width_half    = param.width   / param.widthDivit/2;
                var piece_height_half   = param.height  / param.heightDivit/2;
                
                var texCoords = [
                    1, 1,
                    0, 1,
                    0, 0,
                    1, 0
                ];
                
                this.mesh.vertices   = [];
                this.mesh.colors     = [];
                this.mesh.texCoords  = [];
                this.mesh.indices    = [];
                
                for (var i=0; i<height_divit; ++i) {
                    var offset_z = piece_height*Math.floor(-height_divit/2+1 + i);
                    for (var j=0; j<width_divit; ++j) {
                        var offset_x = piece_width*Math.floor(-width_divit/2.0+1 + j);
                        var currentIndex = (i*width_divit + j)*4;
                        
                        // 頂点
                        this.mesh.vertices = this.mesh.vertices.concat([
                             piece_width_half+offset_x, 0.0, piece_height_half+offset_z,
                            -piece_width_half+offset_x, 0.0, piece_height_half+offset_z,
                            -piece_width_half+offset_x, 0.0,-piece_height_half+offset_z,
                             piece_width_half+offset_x, 0.0,-piece_height_half+offset_z
                        ]);
                        
                        // カラー
                        var colors = null;
                        if (i%2){ colors = (j%2) ? colors0 : colors1; }
                        else    { colors = (j%2) ? colors1 : colors0; }
                        this.mesh.colors = this.mesh.colors.concat(colors);
                        
                        // テクスチャUV
                        this.mesh.texCoords = this.mesh.texCoords.concat(texCoords);
                        
                        // インデックス
                        this.mesh.indices = this.mesh.indices.concat([
                            currentIndex+0, currentIndex+1, currentIndex+2,
                            currentIndex+2, currentIndex+3, currentIndex+0,
                            currentIndex+2, currentIndex+1, currentIndex+0,
                            currentIndex+0, currentIndex+3, currentIndex+2
                        ]);
                    }
                }
                
                // 法線
                this.mesh.normals = this.mesh.vertices;
                
                // 環境光はデフォルトで白
                this.mesh.texture.ambient = [1.0, 1.0, 1.0, 1.0];
            }
            
        });
        
        
        enchant.gl.Floor.COLOR = {
            "white": [
                1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0,
                1.0, 1.0, 1.0, 1.0,
            ],
            
            "black": [
                0.0, 0.0, 0.0, 1.0,
                0.0, 0.0, 0.0, 1.0,
                0.0, 0.0, 0.0, 1.0,
                0.0, 0.0, 0.0, 1.0,
            ],
            
            "red": [
                1.0, 0.0, 0.0, 1.0,
                1.0, 0.0, 0.0, 1.0,
                1.0, 0.0, 0.0, 1.0,
                1.0, 0.0, 0.0, 1.0,
            ],
            
            "green": [
                0.0, 1.0, 0.0, 1.0,
                0.0, 1.0, 0.0, 1.0,
                0.0, 1.0, 0.0, 1.0,
                0.0, 1.0, 0.0, 1.0,
            ],
            
            "blue": [
                0.0, 0.0, 1.0, 1.0,
                0.0, 0.0, 1.0, 1.0,
                0.0, 0.0, 1.0, 1.0,
                0.0, 0.0, 1.0, 1.0,
            ],
            
            "yellow": [
                1.0, 1.0, 0.0, 1.0,
                1.0, 1.0, 0.0, 1.0,
                1.0, 1.0, 0.0, 1.0,
                1.0, 1.0, 0.0, 1.0,
            ],
            
            "cyan": [
                0.0, 1.0, 1.0, 1.0,
                0.0, 1.0, 1.0, 1.0,
                0.0, 1.0, 1.0, 1.0,
                0.0, 1.0, 1.0, 1.0,
            ],
            
            "purple": [
                1.0, 0.0, 1.0, 1.0,
                1.0, 0.0, 1.0, 1.0,
                1.0, 0.0, 1.0, 1.0,
                1.0, 0.0, 1.0, 1.0,
            ],
        }
        
    })();
    
}