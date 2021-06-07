import Foundation

final class CallStation {var usersDB = Set <User>(); var callsDB = [Call]()}
extension CallStation: Station {
    func users() -> [User] {let array = Array(usersDB); return array}
    func add(user: User) {usersDB.insert(user)}
    func remove(user: User) {
        usersDB.remove(user)
        for (index, call) in callsDB.enumerated() {
            if call.incomingUser == user || call.outgoingUser == user && call.status == .calling || call.status == .talk {
                    callsDB[index].status = .ended(reason: .error)}}}
    func execute(action: CallAction) -> CallID? {
        switch action {
        case let .start(from, to):
            if usersDB.contains(from) && usersDB.contains(to) {
                var call = Call(id: UUID(), incomingUser: from, outgoingUser: to, status: .calling)
                for item in callsDB {
                    if item.outgoingUser == to {
                        if (item.status == .talk || item.status == .calling) {
                            call.status = .ended(reason: .userBusy)}}}
                callsDB.append(call)
                return call.id}
            else if (usersDB.contains(from) && !usersDB.contains(to)) || (!usersDB.contains(from) && usersDB.contains(to)){
                let call = Call(id: UUID(), incomingUser: to, outgoingUser: from, status: .ended(reason: .error))
                callsDB.append(call)
                return call.id}
            else {return nil}
        case let .answer(from):
            if !usersDB.contains(from) {return nil}
            for (index, call) in callsDB.enumerated() {
                if call.incomingUser == from || call.outgoingUser == from {
                    if call.status == .calling {
                        callsDB[index].status = .talk
                        return call.id}}}
        case let .end(from):
            for (index, call) in callsDB.enumerated(){
                if call.incomingUser == from || call.outgoingUser == from {
                    if call.status == .calling {
                        callsDB[index].status = .ended(reason: .cancel)
                        return call.id}
                    else if call.status == .talk {
                        callsDB[index].status = .ended(reason: .end)
                        return call.id}}}
        }
    return nil
    }
    func calls() -> [Call] {return callsDB}
    func calls(user: User) -> [Call] {
        var calls = [Call]()
            for call in callsDB {
                if call.incomingUser == user || call.outgoingUser == user {
                    calls.append(call)}}
            return calls}
    func call(id: CallID) -> Call? {
        for call in callsDB {
            if call.id == id {
                return call}}
        return nil}
    func currentCall(user: User) -> Call? {
        for call in callsDB {
            if (call.outgoingUser == user || call.incomingUser == user) && (call.status == .calling || call.status == .talk) {
                return call}}
        return nil}
}
