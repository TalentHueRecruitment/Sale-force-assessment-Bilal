public class AnimalFactory {
    public static Animal createAnimal(String type) {
        switch on type {
            when 'Lion'      { return new Lion(); }
            when 'Cat'       { return new Cat(); }
            when 'Dog'       { return new Dog(); }
            when 'Horse'     { return new Horse(); }
            when 'Alligator' { return new Alligator(); }
            when 'Bear'      { return new Bear(); }
            when 'Cow'       { return new Cow(); }
            when else        { throw new IllegalArgumentException('Unknown animal type: ' + type); }
        }
    }
}
