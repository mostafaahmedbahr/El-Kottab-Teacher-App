import '../../../../main_imports.dart';
 import '../../data/repos/student_repo.dart';
import 'student_states.dart';

class StudentCubit extends Cubit<StudentStates> {
  StudentCubit(this.studentRepo) : super(StudentInitState());

  StudentRepo? studentRepo;
  static StudentCubit get(context) => BlocProvider.of(context);


 



}