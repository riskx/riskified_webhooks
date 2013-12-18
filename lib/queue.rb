class Queue
  
  def Queue.sqs_queue
    SQS_QUEUE
  end

  def self.enq(message)
    self.sqs_queue.send_message JSON.dump(message)
  end
end