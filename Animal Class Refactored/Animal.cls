public abstract inherited sharing class Animal {
    public abstract void makeNoise();
    public abstract void move();
    
    public virtual void swim() {
        // Default: does not swim
        System.debug('This animal does not swim.');
    }

    protected void roar()  { System.debug('Roaring'); }
    protected void meow()  { System.debug('Meowing'); }
    protected void neigh() { System.debug('Neighing'); }
    protected void hiss()  { System.debug('Hissing'); }
    protected void growl() { System.debug('Growling'); }
    protected void moo()   { System.debug('Mooing'); }
    protected void bark()  { System.debug('Barking'); }

    protected void run()   { System.debug('Running'); }
    protected void walk()  { System.debug('Walking'); }
    protected void slide() { System.debug('Sliding'); }
    protected void doSwim(){ System.debug('Swimming'); }
}
