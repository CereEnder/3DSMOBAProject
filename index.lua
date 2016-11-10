Graphics.init()

alttpTileset = Graphics.loadImage("Assets/Graphics/alttp.png")


tileSizeX = 16
tileSizeY = 16 
mapOffsetX =2
mapOffsetY =2

board = { 
          {1,2,1,1,1},
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
  
  for i=1,boardSize do 
    for j=1,boardSize do
      
      local tileMapX = map[i][j] * (tileSizeX)
      local tileMapY = map[i][j] * (tileSizeY)
      
      if board[i][j] == 0 then
        --[[Graphics.drawPartialImage(mapOffsetX+tileX,
                                  mapOffsetY+tileY,
                                  tileSizeX * map[i][j]+mapOffsetX,
                                  tileSizeY * map[i][j]+mapOffsetY,
                                  tileSizeX,
                                  tileSizeY, 
                                  alttpTileset)]]--
        Graphics.drawImageExtended((j-1)*tileSizeX+(tileSizeX/2), 
                                   (i-1)*tileSizeY+(tileSizeY/2), 
                                   tileMapX,
                                   tileMapY, 
                                   tileSizeX, 
                                   tileSizeY, 
                                   0, 
                                   1, 
                                   1,alttpTileset);
      end
      if board[i][j] == 1 then
        --[[Graphics.drawPartialImage(mapOffsetX+tileX,
                                  mapOffsetY+tileY,
                                  tileSizeX * map[i][j]+mapOffsetX,
                                  tileSizeY * map[i][j]+mapOffsetY,
                                  tileSizeX,
                                  tileSizeY, 
                                  alttpTileset)]]--
                                  
        Graphics.drawImageExtended((j-1)*tileSizeX+(tileSizeX/2), 
                                   (i-1)*tileSizeY+(tileSizeY/2), 
                                   tileMapX, 
                                   tileMapY,  
                                   tileSizeX, 
                                   tileSizeY, 
                                   0, 
                                   1, 
                                   1,alttpTileset);
      end
     end
  end
  
  Graphics.fillEmptyRect(heroStats.coordX,heroStats.coordX+heroStats.sizeX,heroStats.coordY,heroStats.coordY+heroStats.sizeY,heroStats.color)

  
  
--[[	Screen.waitVblankStart()--]]

end



heroStats = {
             coordX=0,
             coordY=0,
             speed=0.1,
             sizeX=16,
             sizeY=16,
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
  
  Graphics.initBlend(TOP_SCREEN)
    drawMap(board)
  Graphics.termBlend()
  Screen.debugPrint(10,10,"Hero Tile: " .. math.floor(heroStats.coordX/tileSizeX) .. " , " .. math.floor(heroStats.coordY/tileSizeY),Color.new(255,255,255),TOP_SCREEN)
  Screen.debugPrint(10,20,"circleX,circleY " .. circleX .. " , " .. circleY,Color.new(255,255,255),TOP_SCREEN)
  
 
  Screen.flip()
end
