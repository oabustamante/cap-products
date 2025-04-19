namespace com.training;

using {cuid} from '@sap/cds/common';

type EmailAddresses_01 : array of {
    kind  : String;
    email : String;
};

type EmailAddresses_02 {
    kind  : String;
    email : String;
};

type Emails {
    email_01  :      EmailAddresses_01;
    email_02  : many EmailAddresses_02;
    email_03  : many {
        kind  :      String;
        email :      String;
    }
};

type Gender            : String enum {
    male;
    female;
};

entity Car {
    key ID                 : UUID;
        name               : String;
        virtual discount_1 : Decimal;
        virtual discount_2 : Decimal;
};

// entity ParamProducts(pName : String)     as
//     select from Products {
//         Name,
//         Price,
//         Quantity
//     }
//     where
//         Name = :pName;

// entity ProjParamProducts(pName : String) as projection on Products
//                                             where
//                                                 Name = :pName;

// Many to many
entity Course : cuid {
    Student : Association to many StudentCourse
                  on Student.Course = $self;
};

entity Student : cuid {
    Course : Association to many StudentCourse
                 on Course.Student = $self;
};

entity StudentCourse : cuid {
    Student : Association to Student;
    Course  : Association to Course;
};
