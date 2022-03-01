// Pharoah's Curse BBC Micro graphics extractor

package main

import (
	"fmt"
	"image"
	"image/color"
	"image/png"
	"io/fs"
	"io/ioutil"
	"os"
)

const totalSprites = 33
const spriteWidth = 10
const spriteHeight = 16

// The entire file
var data []byte

// Define the BBC Micro colours, so we can put them into the image
var coloursBBC []color.RGBA

// Decode a byte into its 2 "left" and "right" pixels
func decodePixel(pixel byte) (l, r byte) {
	l = ((pixel & 0b10) >> 1) | ((pixel & 0b1000) >> 2) | ((pixel & 0b100000) >> 3) | ((pixel & 0b10000000) >> 4)
	r = ((pixel & 0b1) >> 0) | ((pixel & 0b100) >> 1) | ((pixel & 0b10000) >> 2) | ((pixel & 0b1000000) >> 3)
	return
}

// Create the BBC Micro colours
func makeBBCMicroColours() {
	coloursBBC = make([]color.RGBA, 16)
	coloursBBC[0] = color.RGBA{0x00, 0x00, 0x00, 0xff}  // black
	coloursBBC[1] = color.RGBA{0xff, 0x00, 0x00, 0xff}  // red
	coloursBBC[2] = color.RGBA{0x00, 0xff, 0x00, 0xff}  // green
	coloursBBC[3] = color.RGBA{0xff, 0xff, 0x00, 0xff}  // yellow
	coloursBBC[4] = color.RGBA{0x00, 0x00, 0xff, 0xff}  // blue
	coloursBBC[5] = color.RGBA{0xff, 0x00, 0xff, 0xff}  // magenta
	coloursBBC[6] = color.RGBA{0x00, 0xff, 0xff, 0xff}  // cyan
	coloursBBC[7] = color.RGBA{0xff, 0xff, 0xff, 0xff}  // white
	coloursBBC[8] = color.RGBA{0x20, 0x20, 0x20, 0xff}  // black 1
	coloursBBC[9] = color.RGBA{0x7f, 0x00, 0x00, 0xff}  // red 1
	coloursBBC[10] = color.RGBA{0x00, 0x7f, 0x00, 0xff} // green 1
	coloursBBC[11] = color.RGBA{0x7f, 0x7f, 0x00, 0xff} // yellow 1
	coloursBBC[12] = color.RGBA{0x00, 0x00, 0x7f, 0xff} // blue 1
	coloursBBC[13] = color.RGBA{0x7f, 0x00, 0x7f, 0xff} // magenta 1
	coloursBBC[14] = color.RGBA{0x00, 0x7f, 0x7f, 0xff} // cyan 1
	coloursBBC[15] = color.RGBA{0x7f, 0x7f, 0x7f, 0xff} // white 1
}

func renderPalette(img *image.RGBA, x int, y int) {
	for i := 0; i < 8; i++ {
		thisColour := coloursBBC[i]
		img.Set(x+0, y+0, thisColour)
		img.Set(x+1, y+0, thisColour)
		img.Set(x+0, y+1, thisColour)
		img.Set(x+1, y+1, thisColour)
		x += 2
	}
}

func renderCharacter(img *image.RGBA, fileOffset int, x int, y int) {
	curX := x
	curY := y

	for i := 0; i < spriteWidth/2; i++ {
		for j := 0; j < spriteHeight; j++ {
			thisByte := data[fileOffset]
			l, r := decodePixel(thisByte)
			pixelOne := coloursBBC[l]
			pixelTwo := coloursBBC[r]
			img.Set(curX, curY, pixelOne)
			img.Set(curX+1, curY, pixelTwo)
			curY++
			fileOffset++
		}
		curX += 2
		curY = y
	}
}

func renderLives(img *image.RGBA, d []byte, x int, y int) {
	offs := 0
	curX, curY := x, y

	for i := 0; i < 2; i++ {
		for j := 0; j < 7; j++ {
			thisByte := d[offs]
			l, r := decodePixel(thisByte)
			pixelOne := coloursBBC[l]
			pixelTwo := coloursBBC[r]
			img.Set(curX, curY, pixelOne)
			img.Set(curX+1, curY, pixelTwo)
			curY++
			offs++
		}
		curY = y
		curX += 2
	}
}

// The pharaoh is stored fairly odd, so we need a special routine for him!
func renderPharaoh(img *image.RGBA, data []byte, x int, y int) {

	renderCol := func(x int, y int, col []byte, swap bool) {
		for _, v := range col {
			l, r := decodePixel(v)
			pixelOne := coloursBBC[l]
			pixelTwo := coloursBBC[r]
			if swap {
				temp := pixelOne
				pixelOne = pixelTwo
				pixelTwo = temp
			}
			img.Set(x, y, pixelOne)
			img.Set(x+1, y, pixelTwo)
			y++
		}
	}

	// Bytes 9311 - 9311 + 23 (first column)
	// Bytes 9357 - 9357 + 23 (second column)
	// Bytes 9403 - 9403 + 23 (third column)
	// Bytes 9449 - 9449 + 23 (fourth column)
	renderCol(x, y, data[9311:9311+23], false)
	renderCol(x+2, y, data[9357:9357+23], false)
	renderCol(x+4, y, data[9403:9403+23], false)
	renderCol(x+6, y, data[9449:9449+23], false)

	// Bytes 9334 - 9334 + 23 (first column)
	// Bytes 9380 - 9380 + 23 (second column)
	// Bytes 9426 - 9426 + 23 (third column)
	renderCol(x-2, y, data[9334:9334+23], false)
	renderCol(x-4, y, data[9380:9380+23], false)
	renderCol(x-6, y, data[9426:9426+23], false)
}

func main() {

	f, err := os.Open("curse.bin")

	if err != nil {
		fmt.Println(err)
		return
	}

	defer f.Close()
	data, err = ioutil.ReadAll(f)

	if err != nil {
		fmt.Println(err)
		return
	}

	makeBBCMicroColours()

	// Create an image in which to display our parsed graphics
	const imageWidth = 640
	const imageHeight = totalSprites * spriteHeight
	black := color.RGBA{0, 0, 0, 0xff}
	//grey := color.RGBA{0x7f, 0x7f, 0x7f, 0xff}
	upLeft := image.Point{0, 0}
	lowRight := image.Point{imageWidth, imageHeight}
	img := image.NewRGBA(image.Rectangle{upLeft, lowRight})

	for y := 0; y < imageHeight; y++ {
		for x := 0; x < imageWidth; x++ {
			img.Set(x, y, black)
		}
	}

	// All graphics are 10x16 and start here:
	ptr := 6391
	x, y := 0, 0

	for i := 0; i < totalSprites; i++ {
		renderCharacter(img, ptr, x, y)
		ptr += (10 / 2) * 16
		x += 10
	}

	// And pharaoh
	renderPharaoh(img, data, 8, 18)

	// lives indicator at 9297, x 4 y 7
	renderLives(img, data[9297:9297+2*7], 16, 18)

	// Render palette
	renderPalette(img, 0, 44)

	// Save it
	pngFile, err := os.Create("image.png")

	if err != nil {
		fmt.Println(err)
		return
	}

	defer pngFile.Close()
	err = png.Encode(pngFile, img)

	if err != nil {
		fmt.Println(err)
		return
	}

	// Replace the snake graphic with red pixels
	snakeStart := 6391 + (5 * 16 * 15)
	snakeEnd := snakeStart + (5 * 16 * 4)
	snakeGraphic := data[snakeStart:snakeEnd]
	newSnakeGraphic := snakeGraphic[:0]
	fmt.Println("Snake starts at", snakeStart)
	for i, v := range snakeGraphic {
		if v == 0x00 {
			newSnakeGraphic = append(newSnakeGraphic, 0)
		} else if v == 0x55 {
			newSnakeGraphic = append(newSnakeGraphic, 1)
		} else if snakeGraphic[i] == 0xaa {
			newSnakeGraphic = append(newSnakeGraphic, 2)
		} else if snakeGraphic[i] == 0xff {
			newSnakeGraphic = append(newSnakeGraphic, 3)
		} else {
			fmt.Printf("Unexpected colour in snake: 0x%02x at %d\n", v, i)
			return
		}
	}

	ioutil.WriteFile("snake.new", newSnakeGraphic, fs.ModePerm)

	// This creates a patch file to jump straight to level 4 so we can see the pharaoh
	levelJump := []byte{0xa9, 0x03, 0x8d, 0x3b, 0x04}
	ioutil.WriteFile("level.patch", levelJump, fs.ModePerm)

	fmt.Println("OK")
}
