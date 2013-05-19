package bill.generator;

public class FindBillCycle {

    int bill_cycle = 1;

    public int getBillCycle(double rate) {

        double bill_amt = rate * 12;
        if (bill_amt >= 0 && bill_amt <= 1500) {
            bill_cycle = 1;
        }
        if (bill_amt >= 1501 && bill_amt <= 4000) {
            bill_cycle = 2;
        }
        if (bill_amt >= 4001 && bill_amt <= 12000) {
            bill_cycle = 4;
        }
        if (bill_amt >= 12001) {
            bill_cycle = 12;
        }
        return bill_cycle;

    }
}
