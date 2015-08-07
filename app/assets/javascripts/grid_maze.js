var MAZES = MAZES || {};

MAZES.drawGrid = function(canvas, maze_json) {
  // figure out how big the cells are based on canvas and grid size
  var rows = maze_json.rows;
  var cols = maze_json.columns;
  var cell_width = canvas.width / cols;
  var cell_height = canvas.height / rows;
  
  ctx = canvas.getContext("2d");
  ctx.fillStyle = "#AAAACC"
  ctx.fillRect(0,0,cell_width*cols, cell_height*rows);
  // draw the bottom line
  ctx.moveTo(0, 0);
  ctx.lineTo(cell_width*cols, 0);
  ctx.stroke();
  
  var top_edge, bottom_edge, left_edge, right_edge;
  var cell_type;
  for (var i = 0; i < rows; i +=1) {
    top_edge = i * cell_height; // top index
    bottom_edge = top_edge + cell_height;
    // draw left of row
    // console.log("drawing left wall: 0 ",top_edge, "to 0",bottom_edge);
    ctx.moveTo(0, top_edge);
    ctx.lineTo(0, bottom_edge);
    ctx.stroke();
    for (var j = 0; j < maze_json.data[i].length; j += 1) {
      // draw bottom and right if needed.
      left_edge = cell_width*j;
      right_edge = left_edge + cell_width;
      cell_type = maze_json.data[i][j];

      // bottom
      if ((cell_type & 1) == 1) {
        //console.log("drawing bottom: ",left_edge,bottom_edge,"to",right_edge,bottom_edge);
        ctx.moveTo(left_edge, bottom_edge);
        ctx.lineTo(right_edge, bottom_edge);
        ctx.stroke();
      }
      // right
      if ((cell_type & 2) == 2) {
        //console.log("drawing right: ",right_edge,top_edge,"to",right_edge,bottom_edge);
        ctx.moveTo(right_edge, top_edge);
        ctx.lineTo(right_edge, bottom_edge);
        ctx.stroke();
      }
      
      //ctx.strokeText(cell_type, left_edge + cell_width/2, top_edge + cell_height/2);
    }
  }
};