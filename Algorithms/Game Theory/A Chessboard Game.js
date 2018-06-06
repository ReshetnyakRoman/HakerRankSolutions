function chessboardGame(x, y) {
    return x%4 == 0 || x%4==3 || y%4==0 || y%4==3 ?  'First' :  'Second'

}

function main() {
    const ws = fs.createWriteStream(process.env.OUTPUT_PATH);
    const t = parseInt(readLine(), 10);

    for (let tItr = 0; tItr < t; tItr++) {
        const [x,y] = readLine().split(' ').map(x=>parseInt(x));
        let result = chessboardGame(x, y);

        ws.write(result + "\n");
    }

    ws.end();
}