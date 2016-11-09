Graphics.init()

alttpTileset = Graphics.loadImage("Assets/Graphics/alttp.png")


tileSizeX = 16
tileSizeY = 16 
mapOffsetX = 1
mapOffsetY = 2

board = { {1,1,1,1,1},
          {1,0,0,0,1},
          {1,0,0,0,1},
          {1,0,0,0,1},
          {1,1,1,1,1}
          }
          
boardSize=5;
 function getTileCoord(coordX,coordY,tileWidth,tileHeight)
  
  local tileCoordX = math.floor(coordX / tileWidth);
  local tileCoordY = math.floor(coordY / tileHeight);
 end
 
 
 
 function drawMap(map)
  
  Graphics.initBlend(TOP_SCREEN)
  for i=1,boardSize do 
    for j=1,boardSize do
      
      local tileX = j * tileSizeX
      local tileY = i * tileSizeY  
      
      if board[i][j] == 0 then
        Graphics.drawPartialImage(tileX,tileY,tileSizeX * map[i][j]+mapOffsetX,tileSizeX*map[i][j]+mapOffsetX,tileSizeX,tileSizeY, alttpTileset)
      end
      if board[i][j] == 1 then
        Graphics.drawPartialImage(tileX,tileY,tileSizeX * map[i][j]+mapOffsetX,tileSizeX*map[i][j]+mapOffsetX,tileSizeX,tileSizeY, alttpTileset)
      end
     end
  end
  
  Graphics.fillEmptyRect(heroStats.coordX,heroStats.coordY,heroStats.coordX+heroStats.sizeX,heroStats.coordY+heroStats.sizeY,heroStats.color)
  Graphics.termBlend()
  
  
--[[	Screen.waitVblankStart()--]]

end



heroStats = {
             coordX=0,
             coordY=0,
             speed=0.1,
             sizeX=32,
             sizeY=32,
             color = Color.new(255,0,0),
             dx=0,
             dy=0,
             facing
            }



while true do
  Screen.refresh()
  circleX,circleY = Controls.readCirclePad()
  
  --mapOffsetX = mapOffsetX-circleX/100 * 0.25
  --mapOffsetY = mapOffsetY+circleY/100 * 0.25
  
  if circleX ~= 0 then
    heroStats.dx=circleX/156
  end
  if circleY ~=0 then
    heroStats.dy=circleY/156
  end
  if (circleX==0) and (circleY ==0) then
    heroStats.dx=0
    heroStats.dy=0
  end
  
  
  heroStats.coordX = heroStats.coordX + (heroStats.dx * heroStats.speed)
  heroStats.coordY = heroStats.coordY - (heroStats.dy * heroStats.speed)
  
  
  if Controls.check(Controls.read(),KEY_A) then
    System.exit()
  end
  
  drawMap(board)
  Screen.debugPrint(10,10,"Hero Tile: " .. math.floor(heroStats.coordX/tileSizeX) .. " , " .. math.floor(heroStats.coordY/tileSizeY),Color.new(255,255,255),TOP_SCREEN)
  Screen.debugPrint(10,20,"circleX,circleY " .. circleX .. " , " .. circleY,Color.new(255,255,255),TOP_SCREEN)
  
 
  Screen.flip()
end
