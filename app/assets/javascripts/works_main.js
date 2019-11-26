// キャンバス
var src_canvas;
var src_ctx;

// イメージ
var image;

window.onload = function () {

  //onloadしたときに実行
  // moveShape()

  src_canvas = document.getElementById("SrcCanvas");
  src_ctx = src_canvas.getContext("2d");

  image = document.getElementById("img_source");

  // クリック時にタブを表示する設定
  body = document.body;
  menu = document.getElementById('conmenu');

  //右クリック時に独自コンテキストメニューを表示する
  src_canvas.addEventListener('contextmenu',function(e){
    menu.style.left = e.pageX + 'px';
    menu.style.top = e.pageY + 'px';
    menu.classList.add('on');
  });

  //左クリック時に独自コンテキストメニューを非表示にする
  body.addEventListener('click',function(){
    if(menu.classList.contains('on')){
      menu.classList.remove('on');
    }
  });

}

function kakunin(btnNo){
  if (btnNo == 1){
    dir = "Bird";
  }else if(btnNo == 2){
    dir = "Non-bird";
  }else{
    dir = "UnKnown";
  }
  ret = confirm(dir + "フォルダへ保存されました");

  if (ret == true){
    let canvas = document.getElementById("RecCanvas");

    let link = document.createElement("a");
    link.href = canvas.toDataURL("images/png");
    var img_name = dir+".png";
    link.download = img_name;
    link.click();
  }
}

// ユーザーによりファイルが追加された
function onAddFile(event) {
  var files;
  var reader = new FileReader();

  var BaseDiv = document.getElementById("BaseDiv");
  console.log("BaseDiv",BaseDiv);

  if(event.target.files){
    files = event.target.files;
  }else{
    files = event.dataTransfer.files;
  }

  // ファイルが読み込まれた
  reader.onload = function (event) {

    // イメージが読み込まれた
    image.onload = function (){
      src_canvas.width  = image.width;
      src_canvas.height = image.height;
      // キャンバスに画像を描画
      src_ctx.drawImage(image,0,0);

      //追加する要素を定義する
      var recDiv = document.createElement('div');
      recDiv.style.position = "absolute";

      //アノテーションの枠の位置の設定
      leftPos= 0;
      topPos = 0;
      recSizeH = 50;
      recSizeW = 50;
      recDiv.style.left = leftPos+"px";
      recDiv.style.top = topPos+"px";
      recDiv.style.minHeight = recSizeH+"px";
      recDiv.style.minWidth = recSizeW+"px";
      recDiv.style.maxHeight = recSizeH+"px";
      recDiv.style.maxWidth = recSizeW+"px";
      recDiv.classList.add("target");
      recDiv.classList.add("drag-and-drop");

      console.log("element",recDiv);

      BaseDiv.appendChild(recDiv);

      moveShape()

    };

    // イメージが読み込めない
    image.onerror  = function (){
      alert('このファイルは読み込めません。');
    };

    image.src = reader.result;
  };
  if (files[0]){
    reader.readAsDataURL(files[0]);
    document.getElementById("inputfile").value = '';
  }
}


function moveShape(){

    //要素の取得
    var elements = document.getElementsByClassName("drag-and-drop");

    //要素内のクリックされた位置を取得するグローバル（のような）変数
    var x;
    var y;

    //マウスが要素内で押されたとき、又はタッチされたとき発火
    for(var i = 0; i < elements.length; i++) {
        elements[i].addEventListener("mousedown", mdown, false);
        elements[i].addEventListener("touchstart", mdown, false);
    }

    //マウスが押された際の関数
    function mdown(e) {

        //クラス名に .drag を追加
        this.classList.add("drag");

        //タッチデイベントとマウスのイベントの差異を吸収
        if(e.type === "mousedown") {
            var event = e;
        } else {
            var event = e.changedTouches[0];
        }

        //要素内の相対座標を取得
        x = event.pageX - this.offsetLeft;
        y = event.pageY - this.offsetTop;

        //ムーブイベントにコールバック
        document.body.addEventListener("mousemove", mmove, false);
        document.body.addEventListener("touchmove", mmove, false);
    }

    //マウスカーソルが動いたときに発火
    function mmove(e) {

        //ドラッグしている要素を取得
        var drag = document.getElementsByClassName("drag")[0];

        //同様にマウスとタッチの差異を吸収
        if(e.type === "mousemove") {
            var event = e;
        } else {
            var event = e.changedTouches[0];
        }

        //フリックしたときに画面を動かさないようにデフォルト動作を抑制
        e.preventDefault();

        //マウスが動いた場所に要素を動かす
        drag.style.top = event.pageY - y + "px";
        drag.style.left = event.pageX - x + "px";

        //マウスボタンが離されたとき、またはカーソルが外れたとき発火
        drag.addEventListener("mouseup", mup, false);
        document.body.addEventListener("mouseleave", mup, false);
        drag.addEventListener("touchend", mup, false);
        document.body.addEventListener("touchleave", mup, false);

    }

    //マウスボタンが上がったら発火
    function mup(e) {
        var drag = document.getElementsByClassName("drag")[0];

        //ムーブベントハンドラの消去
        document.body.removeEventListener("mousemove", mmove, false);
        drag.removeEventListener("mouseup", mup, false);
        document.body.removeEventListener("touchmove", mmove, false);
        drag.removeEventListener("touchend", mup, false);

        //クラス名 .drag も消す
        drag.classList.remove("drag");
    }

}
