import scala.collection.mutable.ListBuffer
import scala.io.Source
trait Censor{
    var filterMap: Map[String, String] = Map()
    def filter(input : List[String]) : List[String]
    def load()
}

class ESCensor() extends Censor{
    filterMap = Map()
    override def filter(input : List[String]) : List[String] = {
        var output = new ListBuffer[String]()
        input.foreach(value => if(filterMap.contains(value)) output += filterMap(value) else output += value)
        output.toList
    }

    override def load(){
        filterMap += ("shoot" -> "pucky")
        filterMap += ("darn" -> "beans")
    }
    load()
}

class ESFileCensor() extends Censor{
    filterMap = Map()
    override def filter(input : List[String]) : List[String] = {
        var output = new ListBuffer[String]()
        input.foreach(value => if(filterMap.contains(value)) output += filterMap(value) else output += value)
        output.toList
    }

    override def load(){
        var keyName = ""
        var counter = 0
        for(line <- Source.fromFile("mapContents.txt").getLines()){
            if(counter == 0) keyName = line
            else filterMap += (keyName -> line)
            counter = (counter + 1) % 2
        }
    }
    load()
}

def main(args: Array[String]) : Unit = 
{
    val list = List("string1", "string2", "string3")
    val curseList = List("valid", "shoot", "valid", "darn")
    // character sum of list entries
    println(list.foldLeft(0)((size, value) => size + value.length))
    // number of entries in list
    println(list.foldLeft(0)((size, value) => size + 1))
    var esc = new ESCensor()
    println(esc.filter(curseList))
    var esFilec = new ESFileCensor()
    println(esFilec.filter(curseList))
}

main(null)