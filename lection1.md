* Без переменных
* Без состояния
* Без побочных эффектов

* Легко распарралелить

* Средства
  * Арифм и логич операции
  * Присваивания
  * Последоват исполнение шагов
  * Управляющие конструкции (циклы, )
    * Т.к. ничего не меняется, то циклы смысла не имеют
  * Процедуры и функции
    * функции

* Функция - черный ящик
  * Без состояния

* Вычисление корней кв. уравнения


    class Result {
        boolean complexFlag;
        double r1;
        double r2;
    }
    static double discriminant (double a, double b, double c) {
        return b*b - 4*a*c;
    }
    static Result squareRoots(double a, double b, double c) {
        Result result = new Result();
        double descr = discriminant(a, b, c);
        result.complexFlag = descr < 0;
        if (result.complexFlag) {
            result.r1 = (-b) / (2*a);
            result.r2 = Math.sqrt(-discr) / (2*a);
        } else {
            result.r1 = (-b + Math.sqrt(discr)) / (2*a);
            result.r2 = (-b - Math.sqrt(discr)) / (2*a);
        }
        return result;
    }

В функц. варианте можно распараллелить, т.к. нет переменных и можно делать вычисления в любом порядке.
Как сделать более функционально на Java?
Псевдо-Java:


    static double discriminant (double a, double b, double c) {
        return b*b - 4*a*c;
    }
    (boolean, double, double) squareRoots(double a, double b, double c) {
        final double descr = discriminant(a, b, c);
        final double complexFlag = descr < 0;
        (complexFlag,
            (complexFlag ? ((-b) / (2*a), sqrt(-discr) / (2*a))
                         : ((-b + sqrt(discr)) / (2*a), (-b - sqrt(discr)) / (2*a))
    }

* Переменных нет, только константы (обозначены final)
* Но константы получают значения не на этапе компиляции, а на этапе выполнения
* Условные выражения
* Любая функция - суперпозиция других функций
* Результат не зависит от порядка вычислений
  * Можно вычислить отдельные части в любом порядке (или параллельно)
  * Часть подвыражений внутри функции выше можно начать считать сразу, например '-b', другие должны ждать пока будет посчитан discr

* Хорошо подходит для обработки больших массивов данных

* Традиционные языки не очень подходят для удобной работы с функциями.
  Например: множество (напр. целых чисел) удобно представлять не набором элементов, а характеристической функцией (на вход элемент - функция выдает принадлежит ли он множеству).

  boolean intSet(int); //описание функционального типа данных

  boolean emptySet(int n) { return false } //пустое множество

  boolean oddSet(int n) { return n % 2 == 1; } // множество неотрицательных нечетных чисел

  Операции над множествами

  intSet addElement (intSet s; int newElem) {
    //описали и вернули новую функцию
    // элемент или входит в старое множество или равен новому
    // элементу
    boolean newSet (int n) { return s(n) || (n == newElem); }
    // вернули новую функцию
    return newSet;
  }

  //множество чисел между заданным min и max
  intSet buildInternal (int min, int max) {
    boolean newSet (int n) { return (n >= min) && (n <= max); }
    return newSet;
  }

  //возвращает true если элемент принадлежит первому множеству и не принадлежит второму
  intSet difference (intSet s1, intSet s2) {
    boolean newSet (int n) { return s1(n) && | s2(n); }
    return newSet;
  }

* Вычисляем выражение

 // принадлежит ли 7 множеству [odds] \ [3]
 difference (oddSet, addElement (emptySet, 3)) (7)

* В Java можно построить программу для работы с функциональным представлением множеств:

  abstract class IntSet {
    abstract boolean has(int elem);

    public static IntSet addElement(final IntSet s, final int n) {
        return new IntSet() {
            public boolean has(int elem) { return elem == n || s.has(elem); }
        };
    }
    public static IntSet buildInternal(final n, final int n) {
        return new IntSet() {
            public boolean has(int elem) { return elem >= n && elem <= n; }
        };
    }
    public static IntSet difference(final IntSet s1, final IntSet s2) {
        return new IntSet() {
            public boolean has(int elem) { return s1.has(elem) && | s2.has(elem); }
        };
    }
    public static void main(String[] args) {
        IntSet emptySet= new IntSet() { public boolean has(int e) { return false; }}
        IntSet oddSet = new IntSet() { public boolean has(int e) { return e % 2 == 1; }}
        System.out.println(difference(oddSet, addElement(emptySet, 3))).has(7);
    }
  }

  Литература

  Филд. Харрисон. Функциональное программирование М: Мир, 1983
  П.Хендерсон. Функциональное программирование. Применение и реализация. М Мир 1983
  А.А. Кубенский. Функциональное программирование ИТМО 2010

  Дополнительная

  Пол Хьюдак. Джон Петерсон. Джозеф Фасеп. Мягкое введение в Haskell. RSDN Magazin 2006
  Graham Hutton Programming in Haskel. 2007
  Bryan O'Sullivan John Goerzen Donald Stewart. Real World Haskell.



