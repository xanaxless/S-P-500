import Foundation

var count = 0
let nslock = NSLock()

let thred1 = Thread {
    for _ in 0..<1000{
        nslock.lock()
        let l = count + 1
        count = l
        nslock.unlock()
    }
}
let thred2 = Thread {
    for _ in 0..<1000{
        nslock.lock()
        let l = count + 1
        count = l
        nslock.unlock()
    }
}

thred1.start()
thred2.start()


print(count)
