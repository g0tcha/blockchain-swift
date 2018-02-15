import Foundation

struct Block {
    
    init(timestamp: Date, data: String, previousBlockHash: Int) {
        self.timestamp = timestamp
        self.data = data
        self.previousBlockHash = previousBlockHash
        
        let basicHash = String(previousBlockHash) + data + String(timestamp.timeIntervalSince1970)
        hash = basicHash.hashValue
    }
    
    let timestamp: Date
    let data: String
    let hash: Int
    let previousBlockHash: Int
    
    static func NewGenesisBlock() -> Block {
        return Block(timestamp: Date(), data: "The Times 03/Jan/2009 Chancellor on brink of second bailout for banks", previousBlockHash: 0)
    }
}

struct Blockchain {
    var blocks: [Block]
    
    init(genesis: Block) {
        blocks = [Block]()
        blocks.append(genesis)
    }
    
    mutating func addBlock(_ data: String) {
        guard let lastBlock = blocks.last else { fatalError("Failed to find genesis block.")}
        let newBlock = Block(timestamp: Date(), data: data, previousBlockHash: lastBlock.hash)
        blocks.append(newBlock)
    }
}

var blockchain = Blockchain(genesis: Block.NewGenesisBlock())

blockchain.addBlock("Satoshi send 5 BTC to Vincent")
blockchain.addBlock("Vincent send 2 BTC to Meg")

for block in blockchain.blocks {
    print(block.data)
}
