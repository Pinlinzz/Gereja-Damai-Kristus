import { Card, CardContent, CardDescription, CardHeader, CardTitle } from './ui/card';
import { Button } from './ui/button';
import { Input } from './ui/input';
import { Label } from './ui/label';
import { Textarea } from './ui/textarea';
import { Badge } from './ui/badge';
import { Dialog, DialogContent, DialogDescription, DialogHeader, DialogTitle, DialogTrigger } from './ui/dialog';
import { MessageSquare, Send, Mail, Bell, Plus, Users, Calendar } from 'lucide-react';

const announcements = [
  {
    id: 1,
    title: 'Sunday Service Changes',
    content: 'Starting next week, Sunday service will begin at 10:30 AM instead of 10:00 AM.',
    date: '2025-01-26',
    type: 'Important',
    recipients: 185
  },
  {
    id: 2,
    title: 'Church Picnic Registration',
    content: 'Registration is now open for the annual church picnic on February 15th. Please sign up at the front desk.',
    date: '2025-01-25',
    type: 'Event',
    recipients: 185
  },
  {
    id: 3,
    title: 'Prayer Request',
    content: 'Please keep the Johnson family in your prayers as they navigate through this difficult time.',
    date: '2025-01-24',
    type: 'Prayer',
    recipients: 185
  },
  {
    id: 4,
    title: 'Volunteer Appreciation',
    content: 'Thank you to all volunteers who helped with the community outreach event last weekend.',
    date: '2025-01-23',
    type: 'General',
    recipients: 42
  },
];

const newsletters = [
  {
    id: 1,
    title: 'Weekly Newsletter - January 26',
    sent: '2025-01-26',
    opens: 142,
    clicks: 38,
    status: 'Sent'
  },
  {
    id: 2,
    title: 'Monthly Update - January 2025',
    sent: '2025-01-20',
    opens: 165,
    clicks: 45,
    status: 'Sent'
  },
  {
    id: 3,
    title: 'Event Reminder - Church Picnic',
    sent: '2025-01-18',
    opens: 158,
    clicks: 62,
    status: 'Sent'
  },
];

export function Communications() {
  return (
    <div className="space-y-6">
      <div className="flex justify-between items-center">
        <div>
          <h1>Communications</h1>
          <p className="text-muted-foreground">
            Manage announcements, newsletters, and member communications
          </p>
        </div>
        <div className="flex gap-2">
          <Dialog>
            <DialogTrigger asChild>
              <Button variant="outline">
                <Mail className="h-4 w-4 mr-2" />
                Send Newsletter
              </Button>
            </DialogTrigger>
            <DialogContent className="sm:max-w-[500px]">
              <DialogHeader>
                <DialogTitle>Send Newsletter</DialogTitle>
                <DialogDescription>
                  Create and send a newsletter to all members
                </DialogDescription>
              </DialogHeader>
              <div className="grid gap-4 py-4">
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="subject" className="text-right">
                    Subject
                  </Label>
                  <Input id="subject" placeholder="Newsletter subject" className="col-span-3" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="content" className="text-right">
                    Content
                  </Label>
                  <Textarea id="content" placeholder="Newsletter content..." className="col-span-3 min-h-[100px]" />
                </div>
              </div>
              <div className="flex justify-end gap-2">
                <Button variant="outline">Save Draft</Button>
                <Button>Send Newsletter</Button>
              </div>
            </DialogContent>
          </Dialog>
          <Dialog>
            <DialogTrigger asChild>
              <Button>
                <Plus className="h-4 w-4 mr-2" />
                New Announcement
              </Button>
            </DialogTrigger>
            <DialogContent className="sm:max-w-[500px]">
              <DialogHeader>
                <DialogTitle>New Announcement</DialogTitle>
                <DialogDescription>
                  Create a new announcement for the congregation
                </DialogDescription>
              </DialogHeader>
              <div className="grid gap-4 py-4">
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="title" className="text-right">
                    Title
                  </Label>
                  <Input id="title" placeholder="Announcement title" className="col-span-3" />
                </div>
                <div className="grid grid-cols-4 items-center gap-4">
                  <Label htmlFor="message" className="text-right">
                    Message
                  </Label>
                  <Textarea id="message" placeholder="Announcement content..." className="col-span-3 min-h-[100px]" />
                </div>
              </div>
              <div className="flex justify-end gap-2">
                <Button variant="outline">Save Draft</Button>
                <Button>Post Announcement</Button>
              </div>
            </DialogContent>
          </Dialog>
        </div>
      </div>

      {/* Communication Stats */}
      <div className="grid grid-cols-1 md:grid-cols-4 gap-4">
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Total Announcements</CardTitle>
            <Bell className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">24</div>
            <p className="text-xs text-muted-foreground">this month</p>
          </CardContent>
        </Card>
        
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Newsletters Sent</CardTitle>
            <Mail className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">8</div>
            <p className="text-xs text-muted-foreground">this month</p>
          </CardContent>
        </Card>
        
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Email Open Rate</CardTitle>
            <MessageSquare className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">86%</div>
            <p className="text-xs text-muted-foreground">above average</p>
          </CardContent>
        </Card>
        
        <Card>
          <CardHeader className="flex flex-row items-center justify-between space-y-0 pb-2">
            <CardTitle className="text-sm font-medium">Active Recipients</CardTitle>
            <Users className="h-4 w-4 text-muted-foreground" />
          </CardHeader>
          <CardContent>
            <div className="text-2xl font-bold">165</div>
            <p className="text-xs text-muted-foreground">89% of members</p>
          </CardContent>
        </Card>
      </div>

      {/* Recent Announcements */}
      <Card>
        <CardHeader>
          <CardTitle>Recent Announcements</CardTitle>
          <CardDescription>Latest announcements and updates</CardDescription>
        </CardHeader>
        <CardContent>
          <div className="space-y-4">
            {announcements.map((announcement) => (
              <div key={announcement.id} className="flex items-start justify-between p-4 bg-muted/50 rounded-lg">
                <div className="flex-1">
                  <div className="flex items-center gap-2 mb-2">
                    <h4 className="font-medium">{announcement.title}</h4>
                    <Badge variant="outline">{announcement.type}</Badge>
                  </div>
                  <p className="text-sm text-muted-foreground mb-2">{announcement.content}</p>
                  <div className="flex items-center gap-4 text-xs text-muted-foreground">
                    <div className="flex items-center gap-1">
                      <Calendar className="h-3 w-3" />
                      {new Date(announcement.date).toLocaleDateString()}
                    </div>
                    <div className="flex items-center gap-1">
                      <Users className="h-3 w-3" />
                      {announcement.recipients} recipients
                    </div>
                  </div>
                </div>
                <div className="flex items-center gap-2">
                  <Button variant="ghost" size="sm">
                    Edit
                  </Button>
                  <Button variant="ghost" size="sm">
                    <Send className="h-4 w-4" />
                  </Button>
                </div>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>

      {/* Newsletter Performance */}
      <Card>
        <CardHeader>
          <CardTitle>Newsletter Performance</CardTitle>
          <CardDescription>Track email engagement and performance</CardDescription>
        </CardHeader>
        <CardContent>
          <div className="space-y-3">
            {newsletters.map((newsletter) => (
              <div key={newsletter.id} className="flex items-center justify-between p-4 border rounded-lg">
                <div className="flex-1">
                  <div className="font-medium">{newsletter.title}</div>
                  <div className="text-sm text-muted-foreground">
                    Sent on {new Date(newsletter.sent).toLocaleDateString()}
                  </div>
                </div>
                <div className="flex items-center gap-6 text-sm">
                  <div className="text-center">
                    <div className="font-medium">{newsletter.opens}</div>
                    <div className="text-muted-foreground">Opens</div>
                  </div>
                  <div className="text-center">
                    <div className="font-medium">{newsletter.clicks}</div>
                    <div className="text-muted-foreground">Clicks</div>
                  </div>
                  <Badge className="bg-green-100 text-green-800">
                    {newsletter.status}
                  </Badge>
                </div>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>
    </div>
  );
}