import csv
import os
import shutil
import glob
#todo clear folder 
class vehicle_t:
    tf = 0;  # total_frame
    ID = 0;
    time = [];
    x = [];
    y = [];
    vel = [];
    acc = [];
    lane = [];
    preced = [];
    follow = [];

    def __init__(self, id, tf):
        self.ID = id;
        self.tf = tf;
        self.time = [];
        self.x = [];
        self.y = [];
        self.vel = [];
        self.acc = [];
        self.lane = [];
        self.preced = [];
        self.follow = [];

    def add(self, row):
        assert(int(row[0])==self.ID)
        assert(int(row[2])==self.tf)
        self.time.append(int(row[3])/1000);
        self.x.append(float(row[4])*0.3048);
        self.y.append(float(row[5])*0.3048);
        self.vel.append(float(row[11])*0.3048);
        self.acc.append(float(row[12])*0.3048)
        self.lane.append(int(row[13]));
        self.preced.append(int(row[20]));
        self.follow.append(int(row[21]));

    def write(self, dir, name):

        if (self.ID == 0):
            return

        f = open('./'+dir+'/'+name+'.txt', 'w');
        for i in range(len(self.time)):
            f.write("{0} {1} {2} {3} {4} {5} {6}\n".format(
                self.time[i],
                self.ID,
                self.x[i],
                self.y[i],
                self.vel[i],
                self.acc[i],
                self.lane[i])
                );
        f.write("\n");
        f.close();

    def write_line(self, dir, name, t):

        if (self.ID == 0):
            return

        f = open('./'+dir+'/'+name+'.txt', 'a');
        
        f.write("{0} {1} {2} {3} {4} {5} {6}\n".format(
            self.time[t],
            self.ID,
            self.x[t],
            self.y[t],
            self.vel[t],
            self.acc[t],
            self.lane[t])
            );
        # f.write("\n");
        f.close();



def main():
    current_id = 0;
    vehicles = dict();
    ng = 0;
    #num = sum(1 for line in open('../../NGSIM_all.csv'));
    #print(num);
    #with open('../../NGSIM_all.csv', mode = 'r') as csvfile:
    remove_list = glob.glob('s*/')
    for i in remove_list:
        shutil.rmtree(i)
    with open('i_80.csv', mode = 'r') as csvfile:
        spamreader = csv.reader(csvfile)
        head = next(spamreader);
        for row in spamreader:
            #print(row)
            ng = ng + 1;
            row_id = int(row[0])
            if row_id<5000:
                # add data
                if(row_id != current_id):


                    # create new vehicle
                    current_id = row_id;
                    vehicles[current_id] = vehicle_t(current_id, int(row[2]));
                vehicles[current_id].add(row);
            else:
                break;
    vehicles[0] = vehicle_t(0,0);
    print("read done, ",ng, " rows")
    #print(vehicles[2].follow);

    sample_counter = 1;
    sc_str = '1';
    for key, v_it in vehicles.items():
        change_id = -1;
        for i in range(len(v_it.lane)-1):
            if(v_it.lane[i+1]!=v_it.lane[i]):
                change_id = i;

        # Get all cars within a period of time
        if (change_id != -1):
            time_max = max(v_it.time)
            time_min = min(v_it.time)

            # print time_min
            # print time_max

            cv_id = key;
            dir_name = 's'+'{0:0>3}'.format(sample_counter);
            if not os.path.exists(dir_name):
                os.mkdir(dir_name);
            vehicles[cv_id].write(dir_name, 'cv');

            # go through all the vehicles again
            for key2, v_it2 in vehicles.items():
            	for k in range(len(v_it2.time)-1): #go through time
                    t = v_it2.time[k];
                    if(t < time_max and t > time_min ):
                        j = v_it.time.index(t);
                        # next lane and distance smaller than 20
                        if (abs(v_it2.lane[k] - v_it.lane[j]) < 2 and abs(v_it2.y[k] - v_it.y[j]) < 20 ): 
                            ov_id = key2;
                            if (key2 == key):
                                break
                            dir_name = 's'+'{0:0>3}'.format(sample_counter);
                            if not os.path.exists(dir_name):
                                os.mkdir(dir_name);
                            vehicles[ov_id].write_line(dir_name, 'ov'+str(ov_id), k);


        # One following car and one preceding car
        # if(change_id != -1):
        #     cv_id = key;
        #     bv_id = v_it.follow[change_id+1];
        #     fv_id = v_it.preced[change_id+1];

        #     #print(cv_id);
        #     #print(v_it.follow);
        #     #print(v_it.preced);
        #     dir_name = 's'+'{0:0>3}'.format(sample_counter);
        #     if not os.path.exists(dir_name):
        #         os.mkdir(dir_name);
        #     vehicles[cv_id].write(dir_name, 'cv');
        #     #print(vehicles[bv_id].ID);
        #     vehicles[bv_id].write(dir_name, 'bv');
        #     vehicles[fv_id].write(dir_name, 'fv');
        #     # if(sample_counter%100 == 0):
        #     #     print('\b'*len(sc_str), end='');
        #     #     sc_str = str(sample_counter);
        #     #     print(sc_str, end='');
        #     print(sample_counter);
            sample_counter += 1;
            #os.system("pause")
        if(sample_counter == 3):
            # print('\b'*len(sc_str), end='')
            print('Done');
            return;
    # print('\b'*len(sc_str), end='');
    print('Not enough car data!');



if __name__ == "__main__":
    main();
