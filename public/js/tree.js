var tree = function(){
  $.ajax({
    url:'browser',
    type:'GET',
    success:children_successback,
    error:children_errorback
  });
};

var get_children = function(_path){
  $.ajax({
    url:'browser',
    type:'GET',
    data:{
      path:_path
    },
    success:children_successback,
    error:children_errorback
  });
};

var get_stat = function(_path){
  $.ajax({
    url:'browser/stat',
    type:'GET',
    data:{
      path:_path
    },
    success:stat_successback,
    error:stat_errorback
  });
};

var get_data = function(_path){
  $.ajax({
    url:'browser/data',
    type:'GET',
    data:{
      path:_path
    },
    success:data_successback,
    error:data_errorback
  });
};

var children_errorback = function(data){
  //TODO
  alert('get children error');
};

var children_successback = function(data){
  if(data==''){
    //TODO
  }else{
    var parent = null;
    if(data[0].parent == null){
      parent = $('#root');
    }else{
      parent = $('#'+data[0].parent.replace(/\//g, '\\/'))
    }
    parent.append('<ul></ul>');
    var ul = parent.children('ul');
    var html = '';
    for(var i in data){
      html += '<li id="'+data[i].id+'"><i class="icon-chevron-right"></i><span title="Collapse this branch"><i class="icon-folder-close"></i>' + data[i].path + '</span><i class="icon-plus"></i><i class="icon-trash"></i></li>';
    }
    ul.html(html);
    ul.children('li').each(function(){
      // 对下拉按钮增加事件
      $(this).children('i.icon-chevron-right').click(function(e){
        if($(this).parent().children('ul').length == 0){
          get_children($(this).parent().attr('id'));
        }else{
          $(this).parent().children('ul').toggle(200);
        }
        $(this).toggleClass('icon-chevron-right icon-chevron-down')
      });
      $(this).children('span').click(function(e){
        if($(this).parent().attr('id')==$('#stat').attr('current')){
          return;
        }else{
          get_stat($(this).parent().attr('id'));
        }
        get_data($(this).parent().attr('id'));
      });
    })
  }
};

var stat_successback = function(data){
  $('#stat > div > div.col-md-6').each(function(){
    if($(this).attr('id')==='ctime' || $(this).attr('id')==='mtime') {
      var date = new Date(data[$(this).attr('id')]);
      $(this).html(date.toLocaleString());
    }else{
      $(this).html(data[$(this).attr('id')]);
    }
  });
};

var stat_errorback = function(data){
  alert('get stat error');
};

var data_successback = function(data){
  $('#data').html(data);
};

var data_errorback = function(data){
  //TODO
  alert('get data error');
};

