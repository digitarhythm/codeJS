#*****************************************
# JSFont - Font dispatch
# Coded by Hajime Oh-yake 2016.12.17
#*****************************************

class JSFont extends JSObject
    constructor:->
        @_fontSize = 12
        @_fontWeight = 'normal'

    systemFontOfSize:(fontsize)->

###
#+(UIFont*)systemFontOfSize:(CGFloat)fontSize   指定されたサイズの標準スタイルのフォントを返す
　UIFont *font = [UIFont systemFontOfSize:20];

#+(UIFont*)boldSystemFontOfSize:(CGFloat)fontSize   指定されたサイズの太字スタイルのフォントを返す
（例）サイズ20の太字フォントを取得する
　UIFont *font = [UIFont boldSystemFontOfSize:20];

#+(UIFont*)italicSystemFontOfSize:(CGFloat)fontSize   指定されたサイズの斜体スタイルのフォントを返す
（例）サイズ20の斜体フォントを取得する
　UIFont *font = [UIFont italicSystemFontOfSize:20];

#+(CGFloat)systemFontSize    標準サイズを返す
（例）UIFont *font =
　　　[UIFont systemFontOfSize:[UIFont systemFontSize]];

#+(CGFloat)smallSystemFontSize   標準サイズよりも小さめのサイズを返す
（例）UIFont *font =[UIFont systemFontOfSize:
　　　　[UIFont smallSystemFontSize]];

#+(CGFloat)labelFontSize     ラベルで使用される標準的なサイズを返す
（例）UIFont *font =
　　　[UIFont systemFontOfSize:[UIFont labelFontSize]];

#+(CGFloat)buttonFontSize+
###
